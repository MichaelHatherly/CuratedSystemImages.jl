module CuratedSystemImages

using SystemImageLoader

const install = @ArtifactInstaller(
    artifact"CairoMakie",
    artifact"DataFrames",
)
const config = ArtifactConfig(install)

end # module
