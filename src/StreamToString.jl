module StreamToString

export stdout_string, with_redirect, redirect_string

"""
    stdout_string(func)

Call `func()` returning captured stdout as a string.
"""
stdout_string(func) = redirect_string(func; stdout=true, stderr=false).stdout

"""
    redirect_string(func; stdout=true, stderr=true, result=true)

Call `result = func()`, optionally capturing `stdout` and/or `stderr` to
strings. Return a named tuple `(result, stdout, stderr)`, where
`stderr` and `stdout` are strings if requested, otherwise `nothing`.
"""
function redirect_string(func; stdout=true, stderr=true, result=true)
    io_stdout = stdout ? IOBuffer() : nothing
    io_stderr = stderr ? IOBuffer() : nothing
    _result = with_redirect(func; stdout=io_stdout, stderr=io_stderr)
    str_stdout = isnothing(io_stdout) ? nothing : String(take!(io_stdout))
    str_stderr = isnothing(io_stderr) ? nothing : String(take!(io_stderr))
    _result = result ? _result : nothing
    return (result=_result, stdout=str_stdout, stderr=str_stderr)
end

"""
    with_redirect(func; stdout=nothing, stderr=nothing)

Call `func` redirecting `stdout` and/or `stderr` to `IO`
objects if requested. The streams are reset to their
original values upon exit or error.
"""
function with_redirect(func; stdout=nothing, stderr=nothing)
    oldstdout = stdout === nothing ? nothing : Base.stdout
    oldstderr = stderr === nothing ? nothing : Base.stderr
    _setio = (iocheck, expr) -> ! isnothing(iocheck) && Base.eval(expr)
    try
        _setio(oldstdout, :(stdout = $stdout))
        _setio(oldstderr, :(stderr = $stderr))
        return func()
    finally
        _setio(oldstdout, :(stdout = $oldstdout))
        _setio(oldstderr, :(stderr = $oldstderr))
    end
end

end # module StreamToString
