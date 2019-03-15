# Building Jobs

In order to build a **jobs workspace**, start in an empty folder and create a `./jobs` sub folder inside it. All your job classes go in this folder. The name of this folder is configurable.

{% page-ref page="../configuration/" %}

All the Ruby files in the `./jobs` folder will be loaded by all of Jobly's commands. It is recommended to only keep Job classes in this folder. If you need to load additional code, you can use the `./app` folder.

{% page-ref page="loading-additional-code.md" %}

Your job classes should simply inherit from `Jobly::Job`, like this:

```ruby
class Hello < Jobly::Job
  def execute
    # Your code here
  end
end
```
