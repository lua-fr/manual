��    N      �  k   �      �  r   �       $  *  �   O	  o   5
  g   �
  y     �  �  �   S  b   >  4  �  j   �  �   A  �    =  �    �  `   �  h   X  �   �  h   �  p     q   �  e   �  h   _     �  %   �  )   
  $   4  A   Y  4   �  y   �    J  �   \  H     I  O  f  �  �   !  �   �"  n  }#  �  �$  �  �&  e  �(  M  �)  �   E+    ,  �   0-  e  .  �   l/  �   0  s  �0  #  I2  �   m3  �   )4  �   �4  �  �5    �7  �  �8  z  u:  �  �;  3  �=  S  �>  �  @  �  �A    zD  g   �E    �E    �F    J  �  (L  7  �N  :   R  /  <R  �  lT  U  cW  �   �X  K  tY  �   �Z    �[  t   �\     ,]  O  :]  �   �_  v   `  l   �`     ca    �a  �   �c  g   �d  F  Le  c   �f  �   �f  �  �g  �  �i    \l  b   tm  m   �m  �   En  l   (o  |   �o  w   p  k   �p  k   �p     bq  %   ~q  )   �q  )   �q  @   �q  2   9r  �   lr  N  �r  �   Ft  Q   !u  �  su  �  �w  �  �y  $  �{  �  �|  �  F~  U   �  �  v�  �  �  �   υ  X  ��    �  �  3�  �   Ê  �   o�  �  f�  [  �  �   i�  �   K�  �   :�    �    �  ;  �  �  Y�  /  �  ]  8�  �  ��    J�  �  i�  :  b�  �   ��  T  -�  �  ��  �  &�    �  �  ��  6   �  E  ��  v  ��  �  s�  �   �  �  �    n�               #   !   K                  D   :             M   (       &       =          
   $              H       %   >   C   5           -          1   3                         E              N             I   *   6   '   J   +   2   L       9   /           F                 0          @   A       B         )   	         4   7   <   ,   ?   ;            "                G      .          8    @C{-------------------------------------------------------------------------} @sect1{basic| @title{Basic Concepts} @description{ @item{@idx{__add}| the addition (@T{+}) operation.  If any operand for an addition is not a number (nor a string coercible to a number), Lua will try to call a metamethod.  First, Lua will check the first operand (even if it is valid).  If that operand does not define a metamethod for @idx{__add}, then Lua will check the second operand.  If Lua can find a metamethod, it calls the metamethod with the two operands as arguments, and the result of the call (adjusted to one value)  is the result of the operation.  Otherwise, it raises an error.  } @item{@idx{__band}| the bitwise AND (@T{&}) operation.  Behavior similar to the addition operation, except that Lua will try a metamethod if any operand is neither an integer nor a value coercible to an integer @see{coercion}.  } @item{@idx{__bnot}| the bitwise NOT (unary @T{~}) operation.  Behavior similar to the bitwise AND operation.  } @item{@idx{__bor}| the bitwise OR (@T{|}) operation.  Behavior similar to the bitwise AND operation.  } @item{@idx{__bxor}| the bitwise exclusive OR (binary @T{~}) operation.  Behavior similar to the bitwise AND operation.  } @item{@idx{__call}| The call operation @T{func(args)}.  This event happens when Lua tries to call a non-function value (that is, @id{func} is not a function).  The metamethod is looked up in @id{func}.  If present, the metamethod is called with @id{func} as its first argument, followed by the arguments of the original call (@id{args}).  All results of the call are the result of the operation.  (This is the only metamethod that allows multiple results.)  } @item{@idx{__concat}| the concatenation (@T{..}) operation.  Behavior similar to the addition operation, except that Lua will try a metamethod if any operand is neither a string nor a number (which is always coercible to a string).  } @item{@idx{__div}| the division (@T{/}) operation.  Behavior similar to the addition operation.  } @item{@idx{__eq}| the equal (@T{==}) operation.  Behavior similar to the addition operation, except that Lua will try a metamethod only when the values being compared are either both tables or both full userdata and they are not primitively equal.  The result of the call is always converted to a boolean.  } @item{@idx{__idiv}| the floor division (@T{//}) operation.  Behavior similar to the addition operation.  } @item{@idx{__index}| The indexing access @T{table[key]}.  This event happens when @id{table} is not a table or when @id{key} is not present in @id{table}.  The metamethod is looked up in @id{table}. @item{@idx{__len}| the length (@T{#}) operation.  If the object is not a string, Lua will try its metamethod.  If there is a metamethod, Lua calls it with the object as argument, and the result of the call (always adjusted to one value)  is the result of the operation.  If there is no metamethod but the object is a table, then Lua uses the table length operation @see{len-op}.  Otherwise, Lua raises an error.  } @item{@idx{__le}| the less equal (@T{<=}) operation.  Unlike other operations, the less-equal operation can use two different events.  First, Lua looks for the @idx{__le} metamethod in both operands, like in the less than operation.  If it cannot find such a metamethod, then it will try the @idx{__lt} metamethod, assuming that @T{a <= b} is equivalent to @T{not (b < a)}.  As with the other comparison operators, the result is always a boolean.  (This use of the @idx{__lt} event can be removed in future versions; it is also slower than a real @idx{__le} metamethod.)  } @item{@idx{__lt}| the less than (@T{<}) operation.  Behavior similar to the addition operation, except that Lua will try a metamethod only when the values being compared are neither both numbers nor both strings.  The result of the call is always converted to a boolean.  } @item{@idx{__mod}| the modulo (@T{%}) operation.  Behavior similar to the addition operation.  } @item{@idx{__mul}| the multiplication (@T{*}) operation.  Behavior similar to the addition operation.  } @item{@idx{__newindex}| The indexing assignment @T{table[key] = value}.  Like the index event, this event happens when @id{table} is not a table or when @id{key} is not present in @id{table}.  The metamethod is looked up in @id{table}. @item{@idx{__pow}| the exponentiation (@T{^}) operation.  Behavior similar to the addition operation.  } @item{@idx{__shl}| the bitwise left shift (@T{<<}) operation.  Behavior similar to the bitwise AND operation.  } @item{@idx{__shr}| the bitwise right shift (@T{>>}) operation.  Behavior similar to the bitwise AND operation.  } @item{@idx{__sub}| the subtraction (@T{-}) operation.  Behavior similar to the addition operation.  } @item{@idx{__unm}| the negation (unary @T{-}) operation.  Behavior similar to the addition operation.  } @sect1{@title{Introduction} @sect2{GC| @title{Garbage Collection} @sect2{TypesSec| @title{Values and Types} @sect2{error| @title{Error Handling} @sect2{globalenv| @title{Environments and the Global Environment} @sect2{metatable| @title{Metatables and Metamethods} A detailed list of events controlled by metatables is given next.  Each operation is identified by its corresponding key. A metatable controls how an object behaves in arithmetic operations, bitwise operations, order comparisons, concatenation, length operation, calls, and indexing.  A metatable also can define a function to be called when a userdata or a table is @link{GC|garbage collected}. All values in Lua are @emph{first-class values}.  This means that all values can be stored in variables, passed as arguments to other functions, and returned as results. Any table used as the value of @id{_ENV} is called an @def{environment}. As an extension language, Lua has no notion of a @Q{main} program: it works @emph{embedded} in a host client, called the @emph{embedding program} or simply the @emphx{host}.  (Frequently, this host is the stand-alone @id{lua} program.)  The host program can invoke functions to execute a piece of Lua code, can write and read Lua variables, and can register @N{C functions} to be called by Lua code.  Through the use of @N{C functions}, Lua can be augmented to cope with a wide range of different domains, thus creating customized programming languages sharing a syntactical framework. As will be discussed in @refsec{variables} and @refsec{assignment}, any reference to a free name (that is, a name not bound to any declaration) @id{var} is syntactically translated to @T{_ENV.var}.  Moreover, every chunk is compiled in the scope of an external local variable named @id{_ENV} @see{chunks}, so @id{_ENV} itself is never a free name in a chunk. Because Lua is an embedded extension language, all Lua actions start from @N{C code} in the host program calling a function from the Lua library.  (When you use Lua standalone, the @id{lua} application is the host program.)  Whenever an error occurs during the compilation or execution of a Lua chunk, control returns to the host, which can take appropriate measures (such as printing an error message). Because metatables are regular tables, they can contain arbitrary fields, not only the event names defined above.  Some functions in the standard library (e.g., @Lid{tostring})  use other fields in metatables for their own purposes. Despite the existence of this external @id{_ENV} variable and the translation of free names, @id{_ENV} is a completely regular name.  In particular, you can define new variables and parameters with that name.  Each reference to a free name uses the @id{_ENV} that is visible at that point in the program, following the usual visibility rules of Lua @see{visibility}. Despite the name, the metamethod for this event can be either a function or a table.  If it is a function, it is called with @id{table} and @id{key} as arguments, and the result of the call (adjusted to one value)  is the result of the operation.  If it is a table, the final result is the result of indexing this table with @id{key}.  (This indexing is regular, not raw, and therefore can trigger another metamethod.)  } Every value in Lua can have a @emph{metatable}.  This @def{metatable} is an ordinary Lua table that defines the behavior of the original value under certain special operations.  You can change several aspects of the behavior of operations over a value by setting specific fields in its metatable.  For instance, when a non-numeric value is the operand of an addition, Lua checks for a function in the field @St{__add} of the value's metatable.  If it finds one, Lua calls this function to perform the addition. For the unary operators (negation, length, and bitwise NOT), the metamethod is computed and called with a dummy second operand, equal to the first one.  This extra operand is only to simplify Lua's internals (by making these operators behave like a binary operation)  and may be removed in future versions.  (For most uses this extra operand is irrelevant.) If you set the step multiplier to a very large number (larger than 10% of the maximum number of bytes that the program may use), the collector behaves like a stop-the-world collector.  If you then set the pause to 200, the collector behaves as in old Lua versions, doing a complete collection every time Lua doubles its memory usage. It is a good practice to add all needed metamethods to a table before setting it as a metatable of some object.  In particular, the @idx{__gc} metamethod works only when this order is followed @see{finalizers}. Like any other reference manual, this document is dry in places.  For a discussion of the decisions behind the design of Lua, see the technical papers available at Lua's web site.  For a detailed introduction to programming in Lua, see Roberto's book, @emphx{Programming in Lua}. Like indices, the values of table fields can be of any type.  In particular, because functions are first-class values, table fields can contain functions.  Thus tables can also carry @emph{methods} @see{func-def}. Like with indexing, the metamethod for this event can be either a function or a table.  If it is a function, it is called with @id{table}, @id{key}, and @id{value} as arguments.  If it is a table, Lua does an indexing assignment to this table with the same key and value.  (This assignment is regular, not raw, and therefore can trigger another metamethod.) Lua can call (and manipulate) functions written in Lua and functions written in C @see{functioncall}.  Both are represented by the type @emph{function}. Lua code can explicitly generate an error by calling the @Lid{error} function.  If you need to catch errors in Lua, you can use @Lid{pcall} or @Lid{xpcall} to call a given function in @emphx{protected mode}. Lua combines simple procedural syntax with powerful data description constructs based on associative arrays and extensible semantics.  Lua is dynamically typed, runs by interpreting bytecode with a register-based virtual machine, and has automatic memory management with incremental garbage collection, making it ideal for configuration, scripting, and rapid prototyping. Lua implements an incremental mark-and-sweep collector.  It uses two numbers to control its garbage-collection cycles: the @def{garbage-collector pause} and the @def{garbage-collector step multiplier}.  Both use percentage points as units (e.g., a value of 100 means an internal value of 1). Lua is a @emph{dynamically typed language}.  This means that variables do not have types; only values do.  There are no type definitions in the language.  All values carry their own type. Lua is a powerful, efficient, lightweight, embeddable scripting language.  It supports procedural programming, object-oriented programming, functional programming, data-driven programming, and data description. Lua is free software, and is provided as usual with no guarantees, as stated in its license.  The implementation described in this manual is available at Lua's official web site, @id{www.lua.org}. Lua is implemented as a library, written in @emphx{clean C}, the common subset of @N{Standard C} and C++.  The Lua distribution includes a host program called @id{lua}, which uses the Lua library to offer a complete, standalone Lua interpreter, for interactive or batch use.  Lua is intended to be used both as a powerful, lightweight, embeddable scripting language for any program that needs one, and as a powerful but lightweight and efficient stand-alone language. Lua keeps a distinguished environment called the @def{global environment}.  This value is kept at a special index in the C registry @see{registry}.  In Lua, the global variable @Lid{_G} is initialized with this same value.  (@Lid{_G} is never used internally.) Lua performs automatic memory management.  This means that you do not have to worry about allocating memory for new objects or freeing it when the objects are no longer needed.  Lua manages memory automatically by running a @def{garbage collector} to collect all @emph{dead objects} (that is, objects that are no longer accessible from Lua).  All memory used by Lua is subject to automatic management: strings, tables, userdata, functions, threads, internal structures, etc. Tables and full userdata have individual metatables (although multiple tables and userdata can share their metatables).  Values of all other types share one single metatable per type; that is, there is one single metatable for all numbers, one for all strings, etc.  By default, a value has no metatable, but the string library sets a metatable for the string type @see{strlib}. Tables are the sole data-structuring mechanism in Lua; they can be used to represent ordinary arrays, lists, symbol tables, sets, records, graphs, trees, etc.  To represent @x{records}, Lua uses the field name as an index.  The language supports this representation by providing @id{a.name} as syntactic sugar for @T{a["name"]}.  There are several convenient ways to create tables in Lua @see{tableconstructor}. Tables, functions, threads, and (full) userdata values are @emph{objects}: variables do not actually @emph{contain} these values, only @emph{references} to them.  Assignment, parameter passing, and function returns always manipulate references to such values; these operations do not imply any kind of copy. The garbage-collector pause controls how long the collector waits before starting a new cycle.  Larger values make the collector less aggressive.  Values smaller than 100 mean the collector will not wait to start a new cycle.  A value of 200 means that the collector waits for the total memory in use to double before starting a new cycle. The garbage-collector step multiplier controls the relative speed of the collector relative to memory allocation.  Larger values make the collector more aggressive but also increase the size of each incremental step.  You should not use values smaller than 100, because they make the collector too slow and can result in the collector never finishing a cycle.  The default is 200, which means that the collector runs at @Q{twice} the speed of memory allocation. The indexing of tables follows the definition of raw equality in the language.  The expressions @T{a[i]} and @T{a[j]} denote the same table element if and only if @id{i} and @id{j} are raw equal (that is, equal without metamethods).  In particular, floats with integral values are equal to their respective integers (e.g., @T{1.0 == 1}).  To avoid ambiguities, any float with integral value used as a key is converted to its respective integer.  For instance, if you write @T{a[2.0] = true}, the actual key inserted into the table will be the integer @T{2}.  (On the other hand, 2 and @St{2} are different Lua values and therefore denote different table entries.) The key for each event in a metatable is a string with the event name prefixed by two underscores; the corresponding values are called @def{metamethods}.  In the previous example, the key is @St{__add} and the metamethod is the function that performs the addition. The library function @Lid{type} returns a string describing the type of a given value @see{predefined}. The type @def{thread} represents independent threads of execution and it is used to implement coroutines @see{coroutine}.  Lua threads are not related to operating-system threads.  Lua supports coroutines on all systems, even those that do not support threads natively. The type @emph{number} uses two internal representations, or two @x{subtypes}, one called @def{integer} and the other called @def{float}.  Lua has explicit rules about when each representation is used, but it also converts between them automatically as needed @see{coercion}.  Therefore, the programmer may choose to mostly ignore the difference between integers and floats or to assume complete control over the representation of each number.  Standard Lua uses 64-bit integers and double-precision (64-bit) floats, but you can also compile Lua so that it uses 32-bit integers and/or single-precision (32-bit) floats.  The option with 32 bits for both integers and floats is particularly attractive for small machines and embedded systems.  (See macro @id{LUA_32BITS} in file @id{luaconf.h}.) The type @emph{table} implements @x{associative arrays}, that is, @x{arrays} that can be indexed not only with numbers, but with any Lua value except @nil and @x{NaN}.  (@emphx{Not a Number} is a special value used to represent undefined or unrepresentable numerical results, such as @T{0/0}.)  Tables can be @emph{heterogeneous}; that is, they can contain values of all types (except @nil).  Any key with value @nil is not considered part of the table.  Conversely, any key that is not part of a table has an associated value @nil. The type @emph{userdata} is provided to allow arbitrary @N{C data} to be stored in Lua variables.  A userdata value represents a block of raw memory.  There are two kinds of userdata: @emphx{full userdata}, which is an object with a block of memory managed by Lua, and @emphx{light userdata}, which is simply a @N{C pointer} value.  Userdata has no predefined operations in Lua, except assignment and identity test.  By using @emph{metatables}, the programmer can define operations for full userdata values @see{metatable}.  Userdata values cannot be created or modified in Lua, only through the @N{C API}.  This guarantees the integrity of data owned by the host program. There are eight @x{basic types} in Lua: @def{nil}, @def{boolean}, @def{number}, @def{string}, @def{function}, @def{userdata}, @def{thread}, and @def{table}.  The type @emph{nil} has one single value, @nil, whose main property is to be different from any other value; it usually represents the absence of a useful value.  The type @emph{boolean} has two values, @false and @true.  Both @nil and @false make a condition false; any other value makes it true.  The type @emph{number} represents both integer numbers and real (floating-point) numbers.  The type @emph{string} represents immutable sequences of bytes.  @index{eight-bit clean} Lua is 8-bit clean: strings can contain any 8-bit value, including @x{embedded zeros} (@Char{\0}).  Lua is also encoding-agnostic; it makes no assumptions about the contents of a string. This section describes the basic concepts of the language. When Lua loads a chunk, the default value for its @id{_ENV} upvalue is the global environment @seeF{load}.  Therefore, by default, free names in Lua code refer to entries in the global environment (and, therefore, they are also called @def{global variables}).  Moreover, all standard libraries are loaded in the global environment and some functions there operate on that environment.  You can use @Lid{load} (or @Lid{loadfile})  to load a chunk with a different environment.  (In C, you have to load the chunk and then change the value of its first upvalue.) When you use @Lid{xpcall} or @Lid{lua_pcall}, you may give a @def{message handler} to be called in case of errors.  This function is called with the original error object and returns a new error object.  It is called before the error unwinds the stack, so that it can gather more information about the error, for instance by inspecting the stack and creating a stack traceback.  This message handler is still protected by the protected call; so, an error inside the message handler will call the message handler again.  If this loop goes on for too long, Lua breaks it and returns an appropriate message.  (The message handler is called only for regular runtime errors.  It is not called for memory-allocation errors nor for errors while running finalizers.) Whenever there is an error, an @def{error object} (also called an @def{error message})  is propagated with information about the error.  Lua itself only generates errors whose error object is a string, but programs may generate errors with any value as the error object.  It is up to the Lua program or its host to handle such error objects. You can change these numbers by calling @Lid{lua_gc} in C or @Lid{collectgarbage} in Lua.  You can also use these functions to control the collector directly (e.g., stop and restart it). You can query the metatable of any value using the @Lid{getmetatable} function.  Lua queries metamethods in metatables using a raw access @seeF{rawget}.  So, to retrieve the metamethod for event @id{ev} in object @id{o}, Lua does the equivalent to the following code: @verbatim{ rawget(getmetatable(@rep{o}) or {}, "__@rep{ev}")  } You can replace the metatable of tables using the @Lid{setmetatable} function.  You cannot change the metatable of other types from Lua code (except by using the @link{debuglib|debug library}); you should use the @N{C API} for that. Project-Id-Version: 
POT-Creation-Date: 2017-09-26 18:29+0200
PO-Revision-Date: 2017-09-26 19:09+0200
Language: fr_FR
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Last-Translator: 
Language-Team: 
X-Generator: Poedit 1.8.11
 @C{-------------------------------------------------------------------------}
@sect1{basic| @title{Concepts de base} @description{ @item{@idx{__add}|
Opération d'addition(@T{+}).
Si un opérande pour une addition n'est pas un nombre
(ni une chaîne assimilable à un nombre),
Lua essaiera d'appeler une metamethod.
Tout d'abord, Lua vérifie le première opérande (même s'il est valide).
Si cet opérande ne définit pas une metamethod pour @idx{__add},
alors Lua vérifie le second opérande.
Si Lua peut trouver une metamethod,
il appelle la metamethod avec les deux opérandes comme arguments
et le résultat de l'appel
(ajusté à une valeur)
est le résultat de l'opération.
Autrement,
cela soulève une erreur.
} @item{@idx{__band}|
Opération AND (@T{&}) bit à bit.
Comportement semblable à l'opération d'addition,
sauf que Lua va essayer une metamethod
si un  opérande n'est ni un nombre entier
ni une valeur assimilable à un entier @see{coercion}.
} @item{@idx{__bnot}|
Opération NOT (unaire @T{~}) bit à bit.
Comportement semblable à l'opération AND bit à bit.
} @item{@idx{__bor}|
Opération OR (@T{|} bit à bit.
Comportement semblable à l'opération AND bit à bit.
} @item{@idx{__ bxor}|
Opération OU (binaire @T{~}) externe bit à bit.
Comportement semblable à l'opération AND bit à bit.
} @item{@idx{__call}|
L'opération d'appel @T{func(args)}.
Cet évenement arrive quand Lua essaye d'appeler une valeur qui n'est pas une fonction
(c'est à dire, @id{func} n'est pas une fonction).
La métaméthode est cherchée dans @id{func}.
Si présente,
la métaméthode est appelée avec @id{func} en tant que premier argument,
suivi par les arguments de l'appel original (@id{args}).
Tous les résultats de l'appel
sont le résultat de l'opération.
(C'est la seule métaméthode qui permet plusieurs résultats.)
} @item{@idx{__concat}|
Opération de concaténation (@T{..}).
Comportement semblable à l'opération d'addition,
sauf que Lua va essayer une metamethod
si un opérande n'est ni une chaîne ni un numéro
(qui est toujours coercible à une chaîne).
} @item{@idx{__div}|
Opération de devision (@T{/}).
Comportement similaire à l'opération d'addition.
} @item{@idx{__eq}|
Opération égale (@T{==}).
Comportement semblable à l'opération d'addition,
sauf que Lua essaiera une metamethod uniquement
lorsque les valeurs en comparaison sont soit deux
table, soit deux userdata
et s'ils ne sont pas primordialement égaux.
Le résultat de l'appel est toujours
converti en booléen.
} @item{@idx{__idiv}|
Opération floor (@T{//}).
Comportement similaire à l'opération d'addition.
} @item{@idx{__index}|
L'accès par clé @T{table[key]}.
Cet événement arrive quand @id{table} n'est pas une table ou
quand @id{key} n'est pas présent dans @id{table}.
Cette métaméthode est recherchée dans @id{table}. @item{@idx{__len}|
Opération de longueur (@T{#}).
Si l'objet n'est pas une chaîne,
Lua va essayer sa metamethod.
S'il y a une metamethod,
Lua l'appelle avec l'objet comme argument,
et le résultat de l'appel
(toujours ajusté à une valeur)
est le résultat de l'opération.
S'il n'y a pas de metamethod mais que l'objet est une table,
alors Lua utilise l'opération de longueur de table @see{len-op}.
Sinon, Lua soulève une erreur.
} @item{@idx{__le}|
L'opération inférieur ou égal (@T{<=}) operation.
Contrairement aux autres opérations,
l'opération inférieur ou égal peut utiliser deux évenements différents.
Premièrement, Lua cherche la métaméthode @idx{__le} dans les deux operandes,
comme dans l'opération strictement inférieur.
Si il ne peut pas trouver cette métaméthode,
alors il va essayer la métaméthode @idx{__lt},
en supposant que @T{a <= b} est équivalent à @T{not (b < a)}.
Comme les autres opérateurs de comparaison,
le résultat est toujours un booléen.
(Cette utilisation de l'évenement @idx{__lt} peut être supprimée dans des versions futures;
elle est aussi plus lente qu'une vraie métaméthode @idx{__le}.)
} @item{@idx{__lt}|
Opération moins (@T{<}).
Comportement semblable à l'opération d'addition,
sauf que Lua essaiera une metamethod uniquement lorsque les valeurs
en comparaison ne sont ni les mêmes, ni deux chaînes.
Le résultat de l'appel est toujours converti en booléen.
} @item{@idx{__mod}|
Opération modulo (@T{%}).
Comportement similaire à l'opération d'addition.
} @item{@idx{__mul}|
Opération de multiplication (@T{*}).
Comportement similaire à l'opération d'addition.
} @item{@idx{__newindex}|
L'affectation par indexation @T{table[key] = value}.
Comme l’événement d'indexation,
cet événement arrive quand @id{table} n'est pas une table ou
quand @id{key} n'est pas présent dans @id{table}. @item{@idx{__pow}|
Opération d'exponentiation (@T{^}).
Comportement similaire à l'opération d'addition.
} @item{@idx{__shl}|
Opération de décalage vers la gauche (@T{<<}).
Comportement semblable à l'opération AND bit à bit.
} @item{@idx{__shr}|
Opération de décalage à droite (@T{>>}).
Comportement semblable à l'opération AND bit à bit.
} @item{@idx{__sub}|
Opération de soustraction (@T{-}).
Comportement similaire à l'opération d'addition.
} @item{@idx{__unm}|
Opération négation (unary @T{-}).
Comportement similaire à l'opération d'addition.
} @sect1{@title{Introduction} @sect2{GC| @title{Garbage Collection} @sect2{TypesSec| @title{Valeurs et types} @sect2{error| @title{Gestion des erreurs} @sect2{globalenv| @title{Environnements et environnement global} @sect2{metatable| @title{Metatbles et Metamethods} Voici une liste détaillée des éventements contrôlés par les metatables.
Chaque opération est identifiée par sa clé correspondante. Une metatable contrôle comment se comporte un objet dans les opérations
arithmétiques, les opérations bit à bit, les comparaisons, les concaténations,
les appels, l'indexation et les opérations de longueur.
Elle peut également définir une fonction appelé quand une userdata
ou une table passe au @link{GC|garbage collector}. Toutes les valeurs dans Lua sont @emph{des valeurs de première classe}.
Cela signifie que toutes les valeurs sont stockées dans des variables, passées comme arguments à des fonctions, et renvoyées comme résultat. Toute table utilisée comme valeur de @id{_ENV} s'appelle un @def{environnement}. En tant que langage d'extension, Lua n'a pas de fonction principale @Q{main} : il fonctionne comme un langage embarqué sur un hôte, appelé @emph{programme embarqué}, ou simplement @emphx{hôte}. (Souvent, cet hôte est un programme @id{lua} autonome.)
Le programme hôte peut appeler des fonctions pour exécuter des morceaux de code Lua, peut écrire et lire des variables Lua, peut enregistrer des @N{fonctions C} pour être appelées avec du code Lua.
Avec l'utilisation de @N{fonctions C}, Lua peut être utilisé dans de nombreux domaines de programmation, et ainsi créer des langages de programmation partageant une même base syntaxique. Comme nous le verrons dans @refsec{variables} et @refsec{assignment},
chaque référence à un nom libre
(c'est à dire, un nom qui n'est pas bound(relié?) à une quelconque déclaration) @id{var}
est syntaxiquement transformé en @T{_ENV.var}.
De plus, chaque morceau est compilé dans la portée d'une
variable locale externe nommée @id{_ENV} @see{chunks},
donc @id{_ENV} lui-même n'est jamais un nom libre dans un morceau. Parce que Lua est un langage d'extension embarqué,
toutes les actions Lua commencent à partir de @N{code C} dans le programme hôte
appelant une fonction de la bibliothèque Lua.
(Lorsque vous utilisez Lua en mode autonome, l'application @id{lua} est le programme hôte.)
Chaque fois qu'une erreur survient pendant
la compilation ou l'exécution d'un morceau de Lua,
le contrôle revient à l'hôte,
qui peut prendre des mesures appropriées
(comme l'impression d'un message d'erreur). Comme les metatables sont des tableaux réguliers,
ils peuvent contenir des champs arbitraires
en plus des noms d'événements définis ci-dessus.
Certaines fonctions de la bibliothèque standard
(e.g., @Lid{tostring})
utilises d'autres champs de la metatable pour leur propre fonctionnement. Malgré l'existence de cette variable externe @id{_ENV} et
la traduction de noms disponible,
@id{_ENV} est un nom complètement normal.
En particulier, vous pouvez définir de nouvelles variables et paramètres avec ce nom.
Chaque référence à un nom disponible utilise le @id{_ENV} qui est
visible à ce stade du programme,
suivant les règles habituelles de visibilité de Lua @see{visibility}. Malgré son nom,
la métaméthode pour cet événement peut être soit une fonction ou une table.
Si c'est une fonction,
elle est appellée avec @id{table} et @id{key} comme arguments,
et le résultat de l'appel
(ajusté à une seule valeur)
est le résultat de l'opération.
Si c'est une table,
le résultat final est le résultat de l'indexation de cette table avec @id{key}.
(Cet indexation est régulière, pas brute,
et peut donc déclencher une autre métamethode.)
} Toute valeur en Lua peut avoir une @empth{metatable}.
Cette @emph{metatable} est une table Lua ordinaire
qui définit le comportement de la valeur d'origine
sous certaines opérations spéciales.
Vous pouvez modifier plusieurs aspects du comportement
des opérations sur une valeur en définissant des champs spécifiques dans sa metatable.
Par exemple, lorsqu'une  valeur non numérique est l'opérande d'une addition,
Lua regarde si le champ de @St{__add} de la metatable de la valeur a pour valeur associée une fonction.
S'il en trouve un, Lua appelle cette fonction pour effectuer l'addition. Dans le cas des opérateurs unaires (négation, longueur, non bit à bit),
la metamethod est appelé avec un second argument factice égal au premier.
Cet argument supplémentaire est uniquement présent pour simplifier
l'implémentation de Lua (en confondant les opérateurs unaires et binaires)
et peut disparaître dans de prochaine version de Lua.
(Dans la plupart des cas, cet argument n'a pas d'utilité.) Si vous définissez le multiplicateur de pas à un très grand nombre
(plus de 10% du nombre maximum
d'octets que le programme peut utiliser),
le collecteur se comporte comme un collecteur de stop-the-world
(c'est à dire qu'un pas réalise un cycle complet).
Si vous réglez la pause sur 200,
le collecteur se comporte comme dans les anciennes versions de Lua,
faire une collection complète chaque fois que Lua double son
utilisation mémoire C'est une bonne pratique d'ajouter toutes les metamethod nécessaires à une table
avant de la configurer comme une metatable d'un objet quelconque.
En particulier, la metamethod @idx{__gc} fonctionne uniquement dans ce cas @see{finalizers} Comme n'importe quel autre manuel de référence, ce document n'a pas pour but d'enseigner, mais de renseigner.
Pour discuter des décisions à propos du design de Lua, voir les documents techniques disponibles sur le site de Lua.
Pour une introduction technique à la programmation en Lua, voir le livre de Roberto, @emphx{Programming in Lua}. Tout comme les indices, les valeurs des champs d'une table peuvent être de tous les types.
En particulier, comme les fonctions sont des valeurs de première classe, elles peuvent être des champs d'une table.
Ainsi, les tables peuvent contenir des @emph{méthodes} @see{func-def}. Comme l'indexation,
la métamethode pour cet évenement peut être soit une fonction, soit une table.
Si c'est une fonction,
elle est appellée avec @id{table}, @id{key}, et @id{value} comme arguments.
Si c'est une table,
Lua fait une affectation par indexation à cette table avec la même clé et valeur.
(Cet affectation est régulier, pas brute,
et peut donc déclencher une autre métamethode.) Lua peut appeler (et manipuler) des fonctions écrites en Lua, et des fonctions écrites en C @see{functioncall}.
Les deux sont représentées par le type @emph{function}. Le code Lua peut générer explicitement une erreur en appelant la fonction @Lid{error}.
Si vous devez capturer des erreurs en Lua,
vous pouvez utiliser @Lid{pcall} ou @Lid{xpcall}
pour appeler une fonction donnée dans le @emphx{mode protégé}. Lua combine une syntaxe procédurale simple avec une puissante construction de description des données basée sur des tableaux associatifs et une sémantique extensible.
Lua est typée dynamiquement, basée sur l'interprétation d'un bytecode et une machine virtuelle. Il possède une gestion de la mémoire avec un garbage collector incrémental, le rendant facilement configurable, scriptable, et un prototypage rapide. Lua met en œuvre un collecteur incrémental de mark-and-sweep.
Il utilise deux nombres pour contrôler ses cycles de garbage-collection:
le @def{garbage-corrector pause} et
le @def{garbage-collector step multiplier}.
Les deux utilisent des points de pourcentage comme des unités
(par exemple, une valeur de 100 signifie une valeur interne de 1). Lua est un @emph{langage typé dynamiquement}.
Cela signifie que les variables n'ont pas de type, seules les valeurs en ont un.
Il n'y a pas de définition de type dans le langage.
Toutes les valeurs portent leur propre type. Lua est un langage de script puissant, efficace, léger, embarquable.
Il supporte la programmation procédurale, la programmation orientée objet, la programmation fonctionnelle, la programmation data-driven et la description de données. Lua est un logiciel libre, et est fourni sans aucune garantie, comme indiqué dans sa licence.
L'implémentation décrite dans ce manuel est disponible sur le site officiel de Lua, @id{www.lua.org}. Lua est implémenté comme une bibliothèque, écrite en @emphx{clean C}, le sous-ensemble issue du @N{Standard C} et C++.
La distribution du Lua comprend un programme hôte nommé @id{lua}, qui utilise la librairie Lua pour offrir un interpréteur Lua complet, et autonome, à utiliser interactivement ou comme interpréteur.
Lua est pensé pour être un langage scriptable à la fois puissant, léger, et embarquable pour les besoins de tous les programmes, et un langage autonome puissant, léger, et efficace. Lua garde un environnement distinct appelé @def{environnement global}.
Cette valeur est conservée dans un index spécial dans un registre C @see{registry}.
En Lua, la variable globale @Lid{_G} est initialisée avec cette même valeur.
(@Lid{_G} n'est jamais utilisé en interne.) Lua effectue une gestion automatique de la mémoire.
Ceci veut dire que
vous n'avez pas à vous soucier d'allouer de la mémoire pour les nouveaux objets
ou de la libérer lorsque les objets ne sont plus nécessaires.
Lua gère automatiquement la mémoire en exécutant
un @def{garbage collector} pour collecter tous les @emph{objets morts}
(c'est à dire les objets qui ne sont plus accessible depuis Lua).
L'intégralité de la mémoire utilisée par Lua est soumise à une gestion automatique :
chaînes, tables, userdata, fonctions, threads, structures internes, etc. Les tables et les full userdata ont chacun leur propre metatable
(plusieurs tables ou userdata peuvent cependant partager une même metatable).
Les valeurs des autres types partagent la même metatable par type;
il y a une table pour tous les numbers, une pour toutes les strings etc.
Par défaut, une valeur n'a pas de metatable définie,
cependant la bibliothèque string définit une metatable pour le type string @see{strlib}. Les tables sont le seul mécanismes de structures de données propres à Lua ; elles peuvent être utilisées pour représenter des tableaux ordinaires, des listes, des tables de symboles, des dictionnaires, des enregistrements, des graphes, des arbres, etc.
Pour représenter les @x{enregistrements}, Lua utilise le champ de nom comme un index.
Le langage supporte cette représentation en fournissant un identifiant @id{a.name} comme sucre syntaxique pour @T{a["name"]}.
Il y a plusieurs façons pratiques de créer des tables en Lua @see{tableconstructor}. Les valeurs de type table, fonction, thread et (full) userdata sont des @emph{objets} :
les variables ne @emph{contiennent} pas ces valeurs, elles @{renvoient} vers elles.
Les affectations, passages de paramètres, et retours de fonctions manipulent toujours des références vers ces valeurs ; ces opérations n'impliquent pas une quelconque copie. Le garbage-collector pause
contrôle la durée pendant laquelle le collecteur attend avant de commencer un nouveau cycle.
Des valeurs plus importantes rendent le collecteur moins agressif.
Les valeurs inférieures à 100 signifient que le collecteur n'attendra pas pour
démarrer un nouveau cycle.
Une valeur de 200 signifie que le collecteur attend que le double de la mémoire total soit utilisé
avant de commencer un nouveau cycle. Le garbage-collector step multiplier
contrôle la vitesse relative du collecteur par rapport à
l'allocation mémoire.
Des valeurs plus importantes rendent le collecteur plus agressif
mais aussi, augmentent la charge de chaque étape.
Vous ne devez pas utiliser des valeurs inférieures à 100,
parce qu'elles rendent le collecteur trop lent et
il est probable que le collecteur ne termine jamais un cycle.
La valeur par défaut est de 200,
ce qui signifie que le collecteur fonctionne à @Q{deux fois}
la vitesse d'allocation de la mémoire. L'indexation des tables suit la définition de l'égalité pure dans le langage. Les expressions @T{a[i]} et @T{a[j]} indiquent le même élément de la table si et seulement si @id{i} et @id{j} sont égaux (c'est à dire, égaux sans méta-méthodes).
En particulier, les flottants avec des valeurs entières sont égaux à leur représentation entière respective (e.g., @T{1.0 == 1}).
Afin d'éviter les ambiguïtés, tous les flottants avec une valeur entière sont automatiquement convertis vers leur forme entière respective.
Par exemple, si vous écrivez @T{a[2.0] = true}, la clé insérée dans la table sera l'entier @T{2} (d'un autre côté, 2 et @St{2} sont deux valeurs différentes et pointent ainsi vers deux entrées de la table différentes). La clé pour chaque événement dans une metatable est une chaîne
avec le nom de l'événement préfixé par deux caractères de soulignement;
les valeurs correspondantes sont appelées @def{metamethods}.
Dans l'exemple précédent, la clé est @St{__add}
et la metamethod est la fonction qui effectue l'addition. La fonction de bibliothèque @Lid{type} renvoie une chaîne de caractères décrivant le type de la valeur passé en argument @see{predefined}. Le type @def{thread} représente des threads d'exécution indépendants de l'exécution et est utilisé pour implémenter des coroutines @see{coroutine}.
Les threads Lua ne sont pas liés aux threads du système d'exploitation.
Lua supporte les coroutines sur tous les systèmes, même sur ceux qui ne supportent pas les threads nativement. Le type @emph{number} utilise deux représentations internes, ou deux @x{subtypes}, une appelée @def{integer}, et une autre appelée @def{float}.
Lua a des règles explicites quant à la représentation à utiliser, mais peut également les convertir automatiquement quand cela est nécessaire @see{coercion}.
Par conséquent, le programmeur peut choisir d'ignorer la différence entre les integers et les floats la plupart du temps, ou bien contrôler complètement quel type utiliser.
Le Lua standard utilise des integers sur 64 bits, et des floats à double précision (64 bits), mais vous pouvez aussi compiler Lua pour le faire utiliser des integers sur 32 bits et/ou des floats à simple précision (32 bits).
Le fait d'utiliser 32 bits pour et les integers, et les floats est particulièrement avantageux pour les petites machines, et les machines embarquées (voir la macro @id{LUA_32BITS} dans le fichier @id{luaconf.h}). Le type @emph{table} implémente les @x{tableaux associatifs} c'est à dire des @x{tableaux} qui peuvent être indexés non seulement avec des nombres, mais avec n'importe quelle valeur Lua exceptés @nil et @x{NaN} (@emphx{Not a Number} est une valeur spéciale utilisée pour représenter des résultats numériques indéfinis ou non représentables, comme par exemple @T{0/0}).
Les tables peuvent-être @emph{hétérogènes} ; c'est à dire qu'elles peuvent contenir des valeurs de tous les types (excepté @nil).
Les clés de valeur associée @nil ne sont pas considérées comme faisant partie de la table.
Réciproquement, toute clé qui ne fait pas partie de la table a pour valeur associée @nil. Le type @emph{userdata} est capable de stocker des @N{C data} dans des variables Lua.
Une variable de type userdata représente un bloc mémoire.
Il y a deux types d'userdata : 
@emphx{full userdata}, qui est un objet dont l'emplacement en mémoire est géré par Lua,
et @emphx{light userdata}, qui est simplement une valeur de type @N{pointeur C}.
Le type userdata n'a pas d'opérations prédéfinies en Lua, en dehors de l'affectation et des tests d'identité.
En utilisant les @emph{metatables}, le programmeur peut définir des opérations sur les valeurs de type full userdata @see{metatable}.
Les valeurs de type userdata ne peuvent pas être créer ou modifier en Lua, mais uniquement en utilisant @N{l'API C}.
Cela garantit l'intégrité des données propres au programme hôte. Il y a huit @x{types de base} en Lua :
@def{nil}, @def{boolean}, @def{number},
@def{string}, @def{function}, @def{userdata},
@def{thread}, et @def{table}.
Le type @emph{nil} ne contient qu'une valeur, @nil, qui a la principale propriété d'être différente de toutes les autres valeurs ; il représente usuellement l'absence de valeur utile.
Le type @emph{boolean} contient deux valeurs, @false et @true.
@nil et @false sont des conditions fausses ; toutes les autres valeurs sont des conditions vraies.
Le type @emph{number} représente à la fois les nombres entiers, et réels.
Le type @emph{string} représente des séquences d'octets immuables.
@index{eight-bin clean}
Lua est 8-bit clean :
Les strings peuvent contenir n'importes quelles valeurs de 8 bits, incluant les @x{embedded zeros} (@Char{\0}).
Lua est aussi indépendant de l'encodage ; il ne suppose rien sur le contenu d'un string. Cette section décrit les concepts de base du langage. Quand Lua charge un morceau,
la valeur par défaut pour sa valeur ?????????????????????????????? @id{_ENV}
est l'environnement global @seeF{load}.
Par conséquent, par défaut,
les noms disponibles dans le code Lua se réfèrent aux entrées dans l'environnement global
(et, par conséquent, ils sont également appelés @def{variables globales}).
En outre, toutes les bibliothèques standard sont chargées dans l'environnement global
et certaines fonctions fonctionnent dans cet environnement.
(En C, vous devez charger le morceau puis modifier la valeur de sa première ??????.) Lorsque vous utilisez @Lid{xpcall} ou @Lid{lua_pcall},
vous pouvez passer un @def{gestionnaire de message}
à appeler en cas d'erreurs.
Cette fonction est appelée avec l'objet d'erreur d'origine
et renvoie un nouvel objet d'erreur.
Il est appelé avant que l'erreur déroule la pile,
afin qu'il puisse recueillir plus d'informations sur l'erreur,
par exemple en inspectant la pile et en créant une trace de la pile.
Ce gestionnaire de message est toujours protégé par un appel protégé;
donc, une erreur dans le gestionnaire de messages
appellera à nouveau le gestionnaire de messages.
Si cette boucle dure trop longtemps,
Lua le casse et renvoie un message approprié.
(Le gestionnaire de messages est uniquement appelé pour des erreurs d'exécution régulières.
Il n'est pas appelé ni pour des erreurs d'allocation mémoire
ni pour des erreurs de finalisations d'exécution.) Chaque fois qu'il y a une erreur,
un @def{objet d'erreur} (également appelé @def{message d'erreur})
se propage avec des informations sur l'erreur.
Lua lui même génère seulement des erreurs dont l'objet est une chaîne,
mais les programmes peuvent générer des erreurs avec
n'importe quelle valeur comme objet d'erreur.
C'est au programme Lua ou à son hôte de gérer de tels objets d'erreur. Vous pouvez modifier ces nombres en appelant @Lid{lua_gc} en C
ou @Lid{collectgarbage} en Lua.
Vous pouvez également utiliser ces fonctions pour contrôler directement
le collecteur (par exemple, pour l'arrêter et le redémarrer). Vous pouvez obtenir la metatable de n'importe quelle valeur
en utilisant la fonction @Lid{getmetatable}.
Lua interroge les metamethods dans les metatables en utilisant un accès brut @seeF{rawget}.
Donc, pour récupérer la metamethod pour l'événement @id{ev} dans l'objet @id{o},
Lua fait l'équivalent du coude suivant:
@verbatim{
rawget(getmetatable(@rep{o}) or {}, "__@rep{ev}")
} Vous pouvez remplacer les metatables de tables en utilisant la fonction @Lid{setmetatable}.
Vous ne pouvez pas modifier les metatables d'autres types depuis du code Lua
(sauf en utilisant @link{debuglib|debug library});
vous devrez utiliser @N{l'API C} pour cela. 