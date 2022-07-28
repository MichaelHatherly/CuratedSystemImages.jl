import ArtifactUtils
import Base.BinaryPlatforms: Platform

function latest_tag(folder::String)
    if isdir(folder)
        cd(folder) do
            output = readchomp(`git tag -l`)
            lines = strip.(split(output))
            tags = sort!([VersionNumber(line) for line in lines if !isempty(line)]; rev=true)
            return get(tags, 1, nothing)
        end
    else
        error("not a valid directory")
    end
end
latest_tag(::Nothing) = error("no repo provided")

function image_names(folder::String)
    dir = joinpath(folder, "sysimages")
    return sort!([basename(dir) for dir in readdir(dir; join=true) if isdir(dir)])
end
image_names(::Nothing) = error("no repo provided")

repo = get(ARGS, 1, nothing)
tag = latest_tag(repo)
images = image_names(repo)

url_base = "https://github.com/MichaelHatherly/curated-system-images/releases/download"

version = "1.7"
arch = "x64"

platforms = Dict(
    "ubuntu-latest" => Platform("x86_64", "linux"),
    "macOS-latest" => Platform("x86_64", "macos"),
    "windows-latest" => Platform("x86_64", "windows"),
)

artifact_file = joinpath(@__DIR__, "..", "Artifacts.toml")

for (os, platform) in platforms, image in images
    url = "$(url_base)/v$(tag)/$(image)-$(os)-$(arch)-$(version).tar.gz"
    @info "add artifact" url
    ArtifactUtils.add_artifact!(
        artifact_file, image, url;
        platform, force=true, lazy=true
    )
end

