# CuratedSystemImages.jl

This Julia package provides access to several pre-built system images containing
collections of third-party Julia packages. It requires that your `julia` install
is managed using [`juliaup`](https://github.com/JuliaLang/juliaup).

It is an unregistered package and will remain this way since no package should
include this package in its dependencies. To install use Julia's `Pkg` mode in
your global project environment:

```
(@v1.7) pkg> add https://github.com/MichaelHatherly/CuratedSystemImages.jl
```

Then import the package and run the installer:

```
julia> import CuratedSystemImages

julia> CuratedSystemImages.install()
```

This will open an interactive picker where you can select the individual bundled
system images that you would like to install. Once installed you'll need to close
your `julia` REPL and return to the terminal. You can then use `juliaup status` to
see the names of the newly installed channel names that can be used to launch
`julia` with one of the installed system image bundles.

## Available Images

Currently the following system image bundles are provided:

  - `CairoMakie`, contains the Cairo-based `Makie` backend.
  - `DataFrames`, contains the `DataFrames` and `DataFramesMeta` packages.
  
Requests for additional images can be made to [`curated-system-images`](https://github.com/MichaelHatherly/curated-system-images)
repo where the manifests and build scripts are located for the above images.

## How does it work?

We use the [`SystemImageLoader.jl`](https://github.com/MichaelHatherly/SystemImageLoader.jl)
package to define an installer and loader for the lazy Julia artifacts that contain
the system image bundles. Installing a particular bundle sets up a `juliaup` channel
that points `SystemImageLoader` at the right system image file and associated Julia depot
folder containing the artifacts required by the chosen system image.
