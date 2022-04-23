using StreamToString
using Test

@testset "StreamToString.jl" begin
    str = stdout_string() do
        print("hi")
    end
    @test str == "hi"

    res = redirect_string() do
           print(stdout, "hi out")
           print(stderr, "hi err")
        return 1
    end
    @test res == (result = 1, stdout = "hi out", stderr = "hi err")

    res = redirect_string(; stdout=false) do
           print(stdout, "hi out")
           print(stderr, "hi err")
        return 1
    end
    @test res == (result = 1, stdout = nothing, stderr = "hi err")

    res = redirect_string(; stderr=false) do
           print(stdout, "hi out")
           print(stderr, "hi err")
        return 1
    end
    @test res == (result = 1, stdout = "hi out", stderr = nothing)

    res = redirect_string(; result=false) do
           print(stdout, "hi out")
           print(stderr, "hi err")
        return 1
    end
    @test res == (result = nothing, stdout = "hi out", stderr = "hi err")
end
