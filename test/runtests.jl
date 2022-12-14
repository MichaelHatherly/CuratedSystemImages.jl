using CuratedSystemImages
using Test
using TOML

@testset "CuratedSystemImages" begin
    for image in keys(TOML.parsefile(joinpath(@__DIR__, "..", "Artifacts.toml")))
        @test isdir(CuratedSystemImages.install(image))
        config = CuratedSystemImages.config(Symbol(image))
        @test isdir(config.depot)
        @test isfile(config.image)

        depot = join(insert!(copy(Base.DEPOT_PATH), 2, config.depot), Sys.iswindows() ? ";" : ":")
        cmd = `$(Base.julia_cmd()) -J $(config.image) -e 'print(getfield(Main, Symbol(ARGS[1])))' -- $image`
        @test strip(readchomp(addenv(cmd, "JULIA_DEPOT_PATH" => depot))) == image
    end
end

