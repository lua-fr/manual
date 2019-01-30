#!/bin/lua
--[[
Run `./of_to_html.lua input.of output.html` or `./of_to_html.lua < input.of > output.html`
Depends on lpeg
--]]

local lpeg = require "lpeg"

lpeg.locale(lpeg)

local commands = { "ANSI", "APIEntry", "C", "CId", "Char", "Ci", "En", "LibEntry", "Lid", "M", "N", "Produc", "Q", "Rw", "See", "St", "T", "apii", "bnfNter", "bnfopt", "bnfrep", "bnfter", "def", "defid", "description", "emph", "emphx", "id", "idx", "index", "item", "itemize", "link", "manual", "num", "producbody", "producname", "refsec", "rep", "rw", "sect1", "sect2", "sect3", "sect4", "see", "seeC", "seeF", "sp", "title", "verbatim", "x", "At", "Cdots", "Close", "Open", "Or", "OrNL", "VerBar", "false", "ldots", "leq", "nil", "pi", "true", }

local function escape_html(s)
	return s:gsub('.', {['<'] = '&lt;', ['>'] = '&gt;'})
end

local function see_fun_tag(content)
	local format = '(see <a href="#%s"><code>%s</code></a>)'
	return string.format(format, content, content)
end

local function Lid_tag(content)
	local format = '<a href="#pdf-%s"><code>%s</code></a>'
	return string.format(format, content, content)
end

local function defid_tag(content)
	local format = '<a name="pdf-%s"><code>%s</code></a>'
	return string.format(format, content, content)
end

local function apii_tag(content)
	local o,p,x = content:match('([^,]+),([^,]+),(.+)')
	return string.format('<span class="apii">[-%s, +%s, <em>%s</em>]</span>', o, p, x)
end

local function item_tag(content)
	local s,e,title = content:find('([^\n]-)|')
	if s then
		return string.format('<li><b>%s: </b>%s</li>', title, content:sub(e+1))
	end
	return string.format('<li>%s</li>', content)
end

local function LibEntry_tag(content)
	local s,e,title = content:find('([^\n]+)|')
	if s then
		local short = title:match('%S+')
		return string.format('<hr/><h3><a name="pdf-%s"><code>%s</code></a></h3>%s', short, title, content:sub(e+1))
	end
end

local function simple_tag(tag)
	return string.format('<%s>%%s</%s>', tag, tag)
end

local function producbody_tag(content)
	local s,e = content:find('^%s+')
	if s then content = content:sub(e+1) end
	return content:gsub('\n',' '):gsub('[\t ]+',' '):gsub('@OrNL','|\n        ')
end

local function code_tag(content)
	return string.format('<code>%s</code>', escape_html(content))
end

local function pre_tag(content)
	return string.format('<pre>%s</pre>', escape_html(content))
end

local sub_tag = {
	['C'] = '', ['Ci'] = '',
	['At'] = '@',
	['Cdots'] = '&middot;&middot;&middot;',
	['En'] = '&ndash;',
	['true'] = '<b>true</b>',
	['false'] = '<b>false</b>',
	['nil'] = '<b>nil</b>',
	['pi'] = '&pi;',
	['VerBar'] = '&#124;',
	['ldots'] = '...',
	['leq'] = '&le;',
	['index'] = '', -- je sais pas non plus
	['ANSI'] = 'fonction ISO&nbsp;C <code>%s</code>',
	['CId'] = 'fonction&nbsp;C <code>%s</code>',
	['Char'] = "'<code>%s</code>'",
	['M'] = simple_tag 'em',
	['N'] = function (content) return content:gsub(' ', '&nbsp;') end,
	['Q'] = '"%s"', -- quote ?
	['Rw'] = simple_tag 'b',
	['St'] = function (content) return string.format('"%s"', code_tag(content)) end,
	['T'] = code_tag,
	-- Tag de définition de grammaire
	['Produc'] = pre_tag,
	['bnfNter'] = '%s', -- non-terminal
	['bnfopt'] = '[%s]', -- optionnel
	['bnfrep'] = '{%s}', -- répétition
	['bnfter'] = '&lsquo;<b>%s</b>&rsquo;', -- symbole
	['producbody'] = producbody_tag,
	['producname'] = '    %s ::= ',
	['Close'] = '&lsquo;<b>}</b>&rsquo;',
	['Open'] = '&lsquo;<b>{</b>&rsquo;',
	['Or'] = '|',
	['OrNL'] = '@OrNL',
	-- fin grammaire
	['def'] = simple_tag 'em',
	['description'] = simple_tag 'ul',
	['emph'] = simple_tag 'em',
	['emphx'] = simple_tag 'em',
	['id'] = code_tag,
	['idx'] = code_tag,
	['itemize'] = simple_tag 'ul',
	['manual'] = '%s', -- ok...
	['num'] = '%s',
	['em'] = simple_tag 'em',
	['rw'] = simple_tag 'b',
	['sp'] = simple_tag 'sup',
	['verbatim'] = pre_tag,
	['x'] = '%s',
	-- ref simple
	['Lid'] = Lid_tag,
	['defid'] = defid_tag,
	['seeC'] = see_fun_tag,
	['seeF'] = see_fun_tag,
	['apii'] = apii_tag,
	['item'] = item_tag,
	['LibEntry'] = LibEntry_tag,
	-- special
	['#block'] = '{%s}',
}

local function K (k) -- keyword
  return lpeg.P(k) * -(lpeg.alnum + lpeg.P "_");
end

local command_patt
for _,v in ipairs(commands) do
	if not command_patt then
		command_patt = K(v)
	else
		command_patt = command_patt + K(v)
	end
end

local function text_capture(text)
	return { tag = 'text', content = text }
end

local function my_fun(tag, content)
	assert(type(tag) == 'string')
	return { tag = tag, content = content or {} }
end

local function trim_nl(str)
	local res = str:gsub("^%s*\n(.-)%s*$", "%1")
	if not res then res = str:gsub("^(.-)%s*$", "%1") end
	return res
end

local function block_capture(t)
	return { tag = '#block', content = t }
end

local ligne = 1
local function compteur(s,i,c)
	ligne = ligne + 1
	return i
end

local function pmt(p)
	return lpeg.Cmt(p,compteur)
end

local lang = lpeg.P{
	"S",
	NL = pmt(lpeg.P"\r"^-1 * lpeg.P"\n"),
	normal_word = ("{}" + (lpeg.P(1) - lpeg.S"{}@\n")) ^ 1,
	normal_words = lpeg.V"normal_word" ,--* (lpeg.V"NL" * lpeg.V"normal_word") ^ 0 ,
	block = "{" * lpeg.Ct((lpeg.V"text"))^-1 * "}",
	tag = ("@" * (lpeg.C(command_patt) * lpeg.V"block" ^ -1)) / my_fun,
	line = lpeg.Ct((lpeg.V"tag" + lpeg.V"block" / block_capture + lpeg.C(lpeg.V"normal_words")) ^ 1),
	lines = lpeg.Ct(lpeg.V"line" * (lpeg.V"NL" * lpeg.V"line") ^ 0),
	paras = lpeg.V"lines" * (lpeg.V"NL" ^ 2 * lpeg.V"lines") ^ 0,
	text = lpeg.C(lpeg.V"NL" ^ 1) ^ -1 * lpeg.V"paras" * lpeg.C(lpeg.V"NL" ^ 1) ^ -1,
	S = lpeg.Ct(lpeg.V"text")
}

function find_tag(elem, tag)
	if type(elem) == 'table' then
		if not elem.tag then
			for _,k in ipairs(elem) do
				ret = find_tag(k, tag)
				if ret then return ret end
			end
		else
			if elem.tag == tag then return elem end
			if elem.content then
				return find_tag(elem.content, tag)
			end
		end
	end
	return
end

local function APIEntry_pre(elem)
	elem.header = elem.content[1]
	elem.apii = find_tag(elem.header, 'apii')
	table.remove(elem.content, 1)
end

local section = {}
local function section_pre(elem)
	local cp = #section
	local cs = tonumber(elem.tag:sub(5))
	for i=cp,cs+1,-1 do section[i] = nil end
	section[cs] = (section[cs] or 0) + 1
	elem.id = table.concat(section,'.')

	local para1 = elem.content[1][1]
	if type(para1[1]) == 'string' then
		local s = para1[1]:find('|')
		if s then
			local shortname = para1[1]:sub(1,s-1)
			section[shortname] = elem.id
		end
		table.remove(para1,1)
	end
	local title = para1[1].content[1][1][1]
	if cs < 4 then
		local format = '<h%d>%s &ndash; <a name="%s">%s</a></h%d>'
		para1[1] = string.format(format, cs, elem.id, elem.id, title, cs)
	else
		local format = '<h%d>%s</h%d>'
		para1[1] = string.format(format, cs, title, cs)
	end
end

function link_resolv(content)
	local format = '%s (<a href="#%s">&sect;%s</a>)'
	local s = content:find('|')
	local id = section[content:sub(1,s-1)]
	local content = content:sub(s+1)
	return string.format(format, content, id, id)
end

function refsec_resolv(content)
	local format = '<a href="#%s">&sect;%s</a>'
	local id = section[content]
	return string.format(format, id, id)
end

function see_resolv(content)
	local format = '(voir <a href="#%s">&sect;%s</a>)'
	local id = section[content]
	return string.format(format, id, id)
end

local function APIEntry_tag(elem, content)
	local para1 = para_to_html(elem.tag, elem.header)
	local s,e,prototype = para1:find('([^|]+)|')
	local apii = ''
	if elem.apii then
		apii = sub_tag['apii'](paras_to_html{ tag = '#default', content = elem.apii.content }) .. '\n'
	end
	if s then
		local format = '<hr/><h3><a name="%s"><code>%s</code></a></h3>\n' .. apii .. '<pre>%s</pre>%s'
		local title = prototype:match('%s.-(lua[%w_]+)') -- FIXME yolo
		return string.format(format, title, title, prototype, content)
	end
end

local id_ref = {
	['link'] = link_resolv,
	['refsec'] = refsec_resolv,
	['See'] = refsec_resolv,
	['see'] = see_resolv,
}
local spec_tag = {
	['APIEntry'] = APIEntry_tag,
}

local paraph_comm = { "sect1", "sect2", "sect3", "sect4", }
local paraph_in_paraph = { APIEntry = true, LibEntry = true, }
local pre_rules = {
	--["producbody"] = remove_nl,
	["sect1"] = section_pre, ["sect2"] = section_pre, ["sect3"] = section_pre, ["sect4"] = section_pre,
	["APIEntry"] = APIEntry_pre,
}

local keep_nl_set = { verbatim = true, Produc = true}
local ignore_tag = { apii = true }

local paraph_set = {}
for _,k in ipairs(paraph_comm) do paraph_set[k] = true end

local path = {}
function path.contains(tag)
	for _,v in ipairs(path) do
		if v == tag then return true end
	end
	return false
end

function ref_find(elem)
	if type(elem) == 'table' then
		if not elem.tag then
			for _,k in ipairs(elem) do
				ref_find(k)
			end
		else
			if pre_rules[elem.tag] then
				pre_rules[elem.tag](elem)
			end
			ref_find(elem.content)
		end
	end
end

function line_to_html(tag, line)
	local ret = {}
	for _,k in ipairs(line) do
		if type(k) == 'string' then
			table.insert(ret, k)
		elseif not k.tag then
			table.insert(ret, paras_to_html{ tag = "#default", content = k })
		else
			table.insert(ret, paras_to_html(k))
		end
	end
	local str = table.concat(ret, '')
	return table.concat(ret, '')
end

function para_to_html(tag, para)
	local ret = {}
	for _,k in ipairs(para) do
		table.insert(ret, line_to_html(tag, k))
	end
	local str = table.concat(ret, '\n')
	if tag == 'verbatim' then str = '    ' .. str:gsub('\n', '\n    ') end
	return str
end

function paras_to_html(elem)
	local ret = {}
	local tag = elem.tag
	local paras = elem.content

	if ignore_tag[tag] then return '' end

	table.insert(path, tag)

	for _,k in ipairs(paras) do
		local content = para_to_html(tag, k)
		if #content > 0 then
			if paraph_set[tag] then table.insert(ret, '<p>' .. content .. '</p>\n')
			else table.insert(ret, content) end
		end
	end
	local sep = '\n'
	if keep_nl_set[tag] then sep = '\n\n' end
	if paraph_in_paraph[tag] then sep = '</p>\n<p>' end
	local str = table.concat(ret,sep)
	if keep_nl_set[tag] then str = trim_nl(str) end
	if type(sub_tag[tag]) == 'string' then
		str = string.format(sub_tag[tag], str)
	elseif type(sub_tag[tag]) == 'function' then
		str = sub_tag[tag](str)
	elseif type(id_ref[tag]) == 'function' then
		str = id_ref[tag](str)
	elseif type(spec_tag[tag]) == 'function' then
		str = spec_tag[tag](elem, str)
	end

	table.remove(path)

	return str
end

local header = [[
<html>
<head>
<title>Lua 5.3 Manuel de référence</title>
<link rel="stylesheet" type="text/css" href="https://www.lua.org/lua.css"/>
<link rel="stylesheet" type="text/css" href="https://www.lua.org/manual/manual.css"/>
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
</head>

<body>

<h1>
<a href="https://www.lua.org/home.html"><img src="https://www.lua.org/images/logo.gif" alt="Lua"/></a>
Lua 5.3 Manuel de référence
</h1>

<p>by Roberto Ierusalimschy, Luiz Henrique de Figueiredo, Waldemar Celes</p>
<p>traduction par la communauté <a href="https://lua-fr.github.io/">LuaFr</a></p>

<p>
<small>
Copyright &copy; 2015&ndash;2017 Lua.org, PUC-Rio.
Freely available under the terms of the
<a href="../../license.html">Lua license</a>.
</small>
</p>
<div class="menubar">
<a href="contents.html#contents">contents</a>
&middot;
<a href="contents.html#index">index</a>
&middot;
<a href="../">other versions</a>
</div>
]]
local footer = [[
<p class="footer">
Last update:
Fri Feb  3 07:26:45 BRST 2017
</p>
<!--
Last change: revised for Lua 5.3.4
-->

</body></html>
]]

-- main part

local finname, foutname = table.unpack(arg)
if finname then	io.input(finname) end
if foutname then io.output(foutname) end

local input_string = io.read('a')

local ast = lang:match(input_string)
ref_find(ast)
local html = paras_to_html{ tag = '#default', content = ast}
html = html:match('^%s*(.-)%s*$')

if #html > 0 then
	io.write(header)
	io.write(paras_to_html{ tag = '#default', content = ast})
	io.write(footer)
else
	error(string.format('il semble y avoir une erreur en rapport à avec la ligne %d', ligne))
end
