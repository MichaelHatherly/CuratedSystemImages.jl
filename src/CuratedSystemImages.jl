module CuratedSystemImages

using SystemImageLoader

const install = include("install.jl")
const config = ArtifactConfig(install)

end # module
