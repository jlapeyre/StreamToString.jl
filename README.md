# StreamToString

[![Build Status](https://github.com/jlapeyre/StreamToString.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/jlapeyre/StreamToString.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/jlapeyre/StreamToString.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/jlapeyre/StreamToString.jl)
[![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)
[![JET QA](https://img.shields.io/badge/JET.jl-%E2%9C%88%EF%B8%8F-%23aa4444)](https://github.com/aviatesk/JET.jl)

Redirect stdout and stderr to a `String`.

There are other packages like this. Some have more features. I like this interface.

See docstrings for `stdout_string, with_redirect, redirect_string`.

The simplest, easiest function is `stdout_string`.

#### `stdout_string`

```julia
str = stdout_string() do
    print("hi")
end
```

#### `redirect_string`

The function above, `stdout_string` is a wrapper around the following, more general function.

```julia
julia> res = redirect_string() do
           print(stdout, "hi out")
           print(stderr, "hi err")
           return 1
       end
(result = 1, stdout = "hi out", stderr = "hi err")
```

## Other packages

* [IOCapture.jl](https://github.com/JuliaDocs/IOCapture.jl)

* [Suppressor.jl](https://github.com/JuliaIO/Suppressor.jl)
