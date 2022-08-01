module CuratedSystemImages

using SystemImageLoader

const install = @ArtifactInstaller(
    artifact"CairoMakie",
)
const config = ArtifactConfig(install)

end # module
