# mantle:styles

This package defines styles for mantle.

##Style Guide
- **Framework**: [Bootstrap](http://getbootstrap.com/css/)
- **Icon Font**: [Font Awesome](http://fontawesome.io/)
- **Media Queries**: [Rupture](http://jenius.github.io/rupture/)
- **Mixin Library**: [Nib](http://tj.github.io/nib/)

###Adding Files and styles
- Create a file with the name of associated view or package. Import files into *main.styl* **and** add them to *package.js*:
  - Filename: *viewname.import.styl*
  - Importing: `@import viewname.import`
  - Add to package.js: `api.addFiles('viewname.import.styl');`
- Add custom mixins to *mixins.import.styl*
- Add global styles to  *globals.import.styl*
- Add global variables to *variables.import.styl*

####Syntax Patterns
- Do not use brackets, colons, or semicolons
- Class names should be lowercase, hyphenated and as short as possible while accurately indicating purpose
- Avoid styling with id attributes
- Use single quotes
- Avoid deeply nested selectors
- Prefix variable names and functions with `$`
- Separate multiple selectors with line breaks, not commas:
```
  .class-1
  .class-2
  .class-3
    position absolute
```
- Browser prefixes are added with Nib and Autoprefixer

###Media Queries
Media Queries should be placed near affected element. [Rupture](http://jenius.github.io/rupture/)
 scale follows Bootstrap's breakpoints:
```
scale = 0 768px 992px 1200px
        0---1-----2-----3
```
Usage example (see [Rupture documentation](http://jenius.github.io/rupture/) for other options):
```
  +below(1)
    width 100px
    height 100px

  +between(1, 3)
    background-image url('image.jpg')
```

###Declaration order
Order properties by type. Mixins, extends, functions, etc should be grouped with associated type and placed first in group.
  1. Positioning
  2. Display and Box-Model
  3. Background
  4. Font and text adjustment
  5. Other
  6. Media Queries
  7. Nested Selectors

```
.selector
    // Positioning
    cover()
    position absolute

    // Display and Box-Model
    display inline-block
    overflow hidden
    width 100px
    height 100px
    padding 10px
    border 10px solid #333
    margin 10px

    // Background
    background url

    // Font and text adjustment
    font-family sans-serif
    font-size 16px
    text-align right
    color #fff

    // Other
    transition .2s

    // Media Queries
    +below(1)
      width @width / 2
      height @height / 2

    //Nested Selectors
    &:hover
      color red
```

###Resources:
- https://learnboost.github.io/stylus/
- http://www.lessthan3.com/dev/docs/stylus-style-guide
- http://devguides.clock.co.uk/css/stylus-style-guide
