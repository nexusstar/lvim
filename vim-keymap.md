#Vim Keymap cheatsheet

### Replace the term under the cursor
```
:%s<C-r><C-w>/new value/g
```
"C-r, C-w insert word under cursor"
Or use *, the substitute command uses the last searched one.
And it could be used like so:
```
:%s//new value/g
```
