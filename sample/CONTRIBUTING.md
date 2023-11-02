## Getting started

1. Get the bricks declared on the Mason manifest ([mason.yaml](mason.yaml)).

```sh
mason get
```

2.  Generate the generator brick from `brick` into `sample` as `app1`.

```sh
# Make `very_good_core` using the generator template (from sample/):
mason make very_good_core -c "brick_config.json"
```
