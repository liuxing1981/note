# Gitbook plugins

## emphasize
Add background color of font
```
This text is {% em %}highlighted !{% endem %}
This text is {% em %}highlighted with **markdown**!{% endem %}
This text is {% em type="green" %}highlighted in green!{% endem %}
This text is {% em type="red" %}highlighted in red!{% endem %}
This text is {% em color="#ff0000" %}highlighted with a custom color!{% endem %}
``` 

## klipse 
```
\`\`\`eval-python
print [x + 1 for x in range(10)]
\`\`\`
```

* eval-js for javascript
* eval-clojure for clojurescript
* eval-scheme for scheme
* eval-ruby for ruby
* eval-python for python


## flexible-alerts
```
> [!NOTE]
> An alert of type 'note' using global style 'callout'.

> [!TIP|style:flat|label:My own heading|iconVisibility:hidden]
> An alert of type 'tip' using alert specific style 'flat' which overrides global style 'callout'.
> In addition, this alert uses an own heading and hides specific icon.
```

* NOTE
* Tip
* Warning
* Attention
