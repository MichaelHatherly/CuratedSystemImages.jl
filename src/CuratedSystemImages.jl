module CuratedSystemImages

using SystemImageLoader

include_dependency("../Artifacts.toml")
const install = include("install.jl")
const config = ArtifactConfig(install)

end # module
