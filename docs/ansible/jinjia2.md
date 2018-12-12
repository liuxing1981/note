# jinjia2

## 字符串截取
```
name=abcdef
{{ name[start:end] }}
{{ name[:-2] }} //abcd
{{ name[:2] }} //ab
{{ name[2:3] }} //c
```

## Syntax

    {% ... %} 语句
    {{ ... }} 变量输出
    {# ... #} 语句注解
    #  ... ## 可以代替{%}执行语句，其中##为注解部分 (ansible不好用)
```
# for user in users:
{{user.name}} ## This is a comment
# endfor
```

* \+
* \-
* \*
* /
* // 相除取整数部分 {{ 20 // 7 }} is 2.
* % 余
* ** 乘方 2**4 16
* in
* is 是Tests，用于判断
* | Filters，过滤器
* ~ 用于连接变量 {{ "Hello " ~ name ~ "!" }} Hello world!
### if
```
{% extends layout_template if layout_template is defined else 'master.html' %}
```
```
{% if var is undined %}
ok
{% endif %}
```
### for
* loop.index 	The current iteration of the loop. (1 indexed)
* loop.index0 	The current iteration of the loop. (0 indexed)
* loop.revindex 	The number of iterations from the end of the loop (1 indexed)
* loop.revindex0 	The number of iterations from the end of the loop (0 indexed)
* loop.first 	True if first iteration.
* loop.last 	True if last iteration.
* loop.length 	The number of items in the sequence.
* loop.cycle 	A helper function to cycle between a list of sequences. See the explanation below.
* loop.depth 	Indicates how deep in a recursive loop the rendering currently is. Starts at level 1
* loop.depth0 	Indicates how deep in a recursive loop the rendering currently is. Starts at level 0
* loop.previtem 	The item from the previous iteration of the loop. Undefined during the first iteration.
* loop.nextitem 	The item from the following iteration of the loop. Undefined during the last iteration.
* loop.changed(*val) 	True if previously called with a different value (or not called at all).
```
{% for user in users %}
{{user.name}}
{% endfor %}
```
### with (new version 2.3)
代码块，里面的变量为局部变量，离开with块就失效。
```
{% with %}
    {% set foo = 42 %}
    {{ foo }}           foo is 42 here
{% endwith %}
foo is not visible here any longer
```

## Filters

abs(number)

    Return the absolute value of the argument.

attr(obj, name)

    Get an attribute of an object. foo|attr("bar") works like foo.bar just that always an attribute is returned and items are not looked up.

    See Notes on subscriptions for more details.

batch(value, linecount, fill_with=None)

    A filter that batches items. It works pretty much like slice just the other way round. It returns a list of lists with the given number of items. If you provide a second parameter this is used to fill up missing items. See this example:

    <table>
    {%- for row in items|batch(3, '&nbsp;') %}
      <tr>
      {%- for column in row %}
        <td>{{ column }}</td>
      {%- endfor %}
      </tr>
    {%- endfor %}
    </table>

capitalize(s)

    Capitalize a value. The first character will be uppercase, all others lowercase.

center(value, width=80)

    Centers the value in a field of a given width.

default(value, default_value=u'', boolean=False)

    If the value is undefined it will return the passed default value, otherwise the value of the variable:

    {{ my_variable|default('my_variable is not defined') }}

    This will output the value of my_variable if the variable was defined, otherwise 'my_variable is not defined'. If you want to use default with variables that evaluate to false you have to set the second parameter to true:

    {{ ''|default('the string was empty', true) }}

    Aliases:	d

dictsort(value, case_sensitive=False, by='key', reverse=False)

    Sort a dict and yield (key, value) pairs. Because python dicts are unsorted you may want to use this function to order them by either key or value:

    {% for item in mydict|dictsort %}
        sort the dict by key, case insensitive

    {% for item in mydict|dictsort(reverse=true) %}
        sort the dict by key, case insensitive, reverse order

    {% for item in mydict|dictsort(true) %}
        sort the dict by key, case sensitive

    {% for item in mydict|dictsort(false, 'value') %}
        sort the dict by value, case insensitive

escape(s)

    Convert the characters &, <, >, ‘, and ” in string s to HTML-safe sequences. Use this if you need to display text that might contain such characters in HTML. Marks return value as markup string.
    Aliases:	e

filesizeformat(value, binary=False)

    Format the value like a ‘human-readable’ file size (i.e. 13 kB, 4.1 MB, 102 Bytes, etc). Per default decimal prefixes are used (Mega, Giga, etc.), if the second parameter is set to True the binary prefixes are used (Mebi, Gibi).

first(seq)

    Return the first item of a sequence.

float(value, default=0.0)

    Convert the value into a floating point number. If the conversion doesn’t work it will return 0.0. You can override this default using the first parameter.

forceescape(value)

    Enforce HTML escaping. This will probably double escape variables.

format(value, *args, **kwargs)

    Apply python string formatting on an object:

    {{ "%s - %s"|format("Hello?", "Foo!") }}
        -> Hello? - Foo!

groupby(value, attribute)

    Group a sequence of objects by a common attribute.

    If you for example have a list of dicts or objects that represent persons with gender, first_name and last_name attributes and you want to group all users by genders you can do something like the following snippet:

    <ul>
    {% for group in persons|groupby('gender') %}
        <li>{{ group.grouper }}<ul>
        {% for person in group.list %}
            <li>{{ person.first_name }} {{ person.last_name }}</li>
        {% endfor %}</ul></li>
    {% endfor %}
    </ul>

    Additionally it’s possible to use tuple unpacking for the grouper and list:

    <ul>
    {% for grouper, list in persons|groupby('gender') %}
        ...
    {% endfor %}
    </ul>

    As you can see the item we’re grouping by is stored in the grouper attribute and the list contains all the objects that have this grouper in common.

    Changed in version 2.6: It’s now possible to use dotted notation to group by the child attribute of another attribute.

indent(s, width=4, first=False, blank=False, indentfirst=None)

    Return a copy of the string with each line indented by 4 spaces. The first line and blank lines are not indented by default.
    Parameters:	

        width – Number of spaces to indent by.
        first – Don’t skip indenting the first line.
        blank – Don’t skip indenting empty lines.

    Changed in version 2.10: Blank lines are not indented by default.

    Rename the indentfirst argument to first.

int(value, default=0, base=10)

    Convert the value into an integer. If the conversion doesn’t work it will return 0. You can override this default using the first parameter. You can also override the default base (10) in the second parameter, which handles input with prefixes such as 0b, 0o and 0x for bases 2, 8 and 16 respectively. The base is ignored for decimal numbers and non-string values.

join(value, d=u'', attribute=None)

    Return a string which is the concatenation of the strings in the sequence. The separator between elements is an empty string per default, you can define it with the optional parameter:

    {{ [1, 2, 3]|join('|') }}
        -> 1|2|3

    {{ [1, 2, 3]|join }}
        -> 123

    It is also possible to join certain attributes of an object:

    {{ users|join(', ', attribute='username') }}

    New in version 2.6: The attribute parameter was added.

last(seq)

    Return the last item of a sequence.

length(object)

    Return the number of items of a sequence or mapping.
    Aliases:	count

list(value)

    Convert the value into a list. If it was a string the returned list will be a list of characters.

lower(s)

    Convert a value to lowercase.

map()

    Applies a filter on a sequence of objects or looks up an attribute. This is useful when dealing with lists of objects but you are really only interested in a certain value of it.

    The basic usage is mapping on an attribute. Imagine you have a list of users but you are only interested in a list of usernames:

    Users on this page: {{ users|map(attribute='username')|join(', ') }}

    Alternatively you can let it invoke a filter by passing the name of the filter and the arguments afterwards. A good example would be applying a text conversion filter on a sequence:

    Users on this page: {{ titles|map('lower')|join(', ') }}

    New in version 2.7.

max(value, case_sensitive=False, attribute=None)

    Return the largest item from the sequence.

    {{ [1, 2, 3]|max }}
        -> 3

    Parameters:	

        case_sensitive – Treat upper and lower case strings as distinct.
        attribute – Get the object with the max value of this attribute.

min(value, case_sensitive=False, attribute=None)

    Return the smallest item from the sequence.

    {{ [1, 2, 3]|min }}
        -> 1

    Parameters:	

        case_sensitive – Treat upper and lower case strings as distinct.
        attribute – Get the object with the max value of this attribute.

pprint(value, verbose=False)

    Pretty print a variable. Useful for debugging.

    With Jinja 1.2 onwards you can pass it a parameter. If this parameter is truthy the output will be more verbose (this requires pretty)

random(seq)

    Return a random item from the sequence.

reject()

    Filters a sequence of objects by applying a test to each object, and rejecting the objects with the test succeeding.

    If no test is specified, each object will be evaluated as a boolean.

    Example usage:

    {{ numbers|reject("odd") }}

    New in version 2.7.

rejectattr()

    Filters a sequence of objects by applying a test to the specified attribute of each object, and rejecting the objects with the test succeeding.

    If no test is specified, the attribute’s value will be evaluated as a boolean.

    {{ users|rejectattr("is_active") }}
    {{ users|rejectattr("email", "none") }}

    New in version 2.7.

replace(s, old, new, count=None)

    Return a copy of the value with all occurrences of a substring replaced with a new one. The first argument is the substring that should be replaced, the second is the replacement string. If the optional third argument count is given, only the first count occurrences are replaced:

    {{ "Hello World"|replace("Hello", "Goodbye") }}
        -> Goodbye World

    {{ "aaaaargh"|replace("a", "d'oh, ", 2) }}
        -> d'oh, d'oh, aaargh

reverse(value)

    Reverse the object or return an iterator that iterates over it the other way round.

round(value, precision=0, method='common')

    Round the number to a given precision. The first parameter specifies the precision (default is 0), the second the rounding method:

        'common' rounds either up or down
        'ceil' always rounds up
        'floor' always rounds down

    If you don’t specify a method 'common' is used.

    {{ 42.55|round }}
        -> 43.0
    {{ 42.55|round(1, 'floor') }}
        -> 42.5

    Note that even if rounded to 0 precision, a float is returned. If you need a real integer, pipe it through int:

    {{ 42.55|round|int }}
        -> 43

safe(value)

    Mark the value as safe which means that in an environment with automatic escaping enabled this variable will not be escaped.

select()

    Filters a sequence of objects by applying a test to each object, and only selecting the objects with the test succeeding.

    If no test is specified, each object will be evaluated as a boolean.

    Example usage:

    {{ numbers|select("odd") }}
    {{ numbers|select("odd") }}
    {{ numbers|select("divisibleby", 3) }}
    {{ numbers|select("lessthan", 42) }}
    {{ strings|select("equalto", "mystring") }}

    New in version 2.7.

selectattr()

    Filters a sequence of objects by applying a test to the specified attribute of each object, and only selecting the objects with the test succeeding.

    If no test is specified, the attribute’s value will be evaluated as a boolean.

    Example usage:

    {{ users|selectattr("is_active") }}
    {{ users|selectattr("email", "none") }}

    New in version 2.7.

slice(value, slices, fill_with=None)

    Slice an iterator and return a list of lists containing those items. Useful if you want to create a div containing three ul tags that represent columns:

    <div class="columwrapper">
      {%- for column in items|slice(3) %}
        <ul class="column-{{ loop.index }}">
        {%- for item in column %}
          <li>{{ item }}</li>
        {%- endfor %}
        </ul>
      {%- endfor %}
    </div>

    If you pass it a second argument it’s used to fill missing values on the last iteration.

sort(value, reverse=False, case_sensitive=False, attribute=None)

    Sort an iterable. Per default it sorts ascending, if you pass it true as first argument it will reverse the sorting.

    If the iterable is made of strings the third parameter can be used to control the case sensitiveness of the comparison which is disabled by default.

    {% for item in iterable|sort %}
        ...
    {% endfor %}

    It is also possible to sort by an attribute (for example to sort by the date of an object) by specifying the attribute parameter:

    {% for item in iterable|sort(attribute='date') %}
        ...
    {% endfor %}

    Changed in version 2.6: The attribute parameter was added.

string(object)

    Make a string unicode if it isn’t already. That way a markup string is not converted back to unicode.

striptags(value)

    Strip SGML/XML tags and replace adjacent whitespace by one space.

sum(iterable, attribute=None, start=0)

    Returns the sum of a sequence of numbers plus the value of parameter ‘start’ (which defaults to 0). When the sequence is empty it returns start.

    It is also possible to sum up only certain attributes:

    Total: {{ items|sum(attribute='price') }}

    Changed in version 2.6: The attribute parameter was added to allow suming up over attributes. Also the start parameter was moved on to the right.

title(s)

    Return a titlecased version of the value. I.e. words will start with uppercase letters, all remaining characters are lowercase.

tojson(value, indent=None)

    Dumps a structure to JSON so that it’s safe to use in <script> tags. It accepts the same arguments and returns a JSON string. Note that this is available in templates through the |tojson filter which will also mark the result as safe. Due to how this function escapes certain characters this is safe even if used outside of <script> tags.

    The following characters are escaped in strings:

        <
        >
        &
        '

    This makes it safe to embed such strings in any place in HTML with the notable exception of double quoted attributes. In that case single quote your attributes or HTML escape it in addition.

    The indent parameter can be used to enable pretty printing. Set it to the number of spaces that the structures should be indented with.

    Note that this filter is for use in HTML contexts only.

    New in version 2.9.

trim(value)

    Strip leading and trailing whitespace.

truncate(s, length=255, killwords=False, end='...', leeway=None)

    Return a truncated copy of the string. The length is specified with the first parameter which defaults to 255. If the second parameter is true the filter will cut the text at length. Otherwise it will discard the last word. If the text was in fact truncated it will append an ellipsis sign ("..."). If you want a different ellipsis sign than "..." you can specify it using the third parameter. Strings that only exceed the length by the tolerance margin given in the fourth parameter will not be truncated.

    {{ "foo bar baz qux"|truncate(9) }}
        -> "foo..."
    {{ "foo bar baz qux"|truncate(9, True) }}
        -> "foo ba..."
    {{ "foo bar baz qux"|truncate(11) }}
        -> "foo bar baz qux"
    {{ "foo bar baz qux"|truncate(11, False, '...', 0) }}
        -> "foo bar..."

    The default leeway on newer Jinja2 versions is 5 and was 0 before but can be reconfigured globally.

unique(value, case_sensitive=False, attribute=None)

    Returns a list of unique items from the the given iterable.

    {{ ['foo', 'bar', 'foobar', 'FooBar']|unique }}
        -> ['foo', 'bar', 'foobar']

    The unique items are yielded in the same order as their first occurrence in the iterable passed to the filter.
    Parameters:	

        case_sensitive – Treat upper and lower case strings as distinct.
        attribute – Filter objects with unique values for this attribute.

upper(s)

    Convert a value to uppercase.

urlencode(value)

    Escape strings for use in URLs (uses UTF-8 encoding). It accepts both dictionaries and regular strings as well as pairwise iterables.

    New in version 2.7.

urlize(value, trim_url_limit=None, nofollow=False, target=None, rel=None)

    Converts URLs in plain text into clickable links.

    If you pass the filter an additional integer it will shorten the urls to that number. Also a third argument exists that makes the urls “nofollow”:

    {{ mytext|urlize(40, true) }}
        links are shortened to 40 chars and defined with rel="nofollow"

    If target is specified, the target attribute will be added to the <a> tag:

    {{ mytext|urlize(40, target='_blank') }}

    Changed in version 2.8+: The target parameter was added.

wordcount(s)

    Count the words in that string.

wordwrap(s, width=79, break_long_words=True, wrapstring=None)

    Return a copy of the string passed to the filter wrapped after 79 characters. You can override this default using the first parameter. If you set the second parameter to false Jinja will not split words apart if they are longer than width. By default, the newlines will be the default newlines for the environment, but this can be changed using the wrapstring keyword argument.

    New in version 2.7: Added support for the wrapstring parameter.

xmlattr(d, autospace=True)

    Create an SGML/XML attribute string based on the items in a dict. All values that are neither none nor undefined are automatically escaped:

    <ul{{ {'class': 'my_list', 'missing': none,
            'id': 'list-%d'|format(variable)}|xmlattr }}>
    ...
    </ul>

    Results in something like this:

    <ul class="my_list" id="list-42">
    ...
    </ul>

    As you can see it automatically prepends a space in front of the item if the filter returned something unless the second parameter is false.


## Tests
> Tests就是包含is的语句
```
{% if loop.index is divisibleby 3 %}
{% if loop.index is divisibleby(3) %}
```
* defined
* eq
* escaped
* even 是否为偶数
* ge >=
* gt > {% if var is gt 3 %}  {% if var > 3}
* lower 是否为小写
* mapping 是否为字典
* le
* lt
* iterable 是否可以遍历
* ne
* none
* number
* odd
* string
* undefined 
* upper