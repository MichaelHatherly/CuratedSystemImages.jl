using CuratedSystemImages
import TOML

for each in collect(keys(TOML.parsefile(joinpath(@__DIR__, "..", "Artifacts.toml"))))
    @show isdir(CuratedSystemImages.install(each))
end

