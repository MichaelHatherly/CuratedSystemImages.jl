# CuratedSystemImages.jl

> **Note**
>
> **Windows users** need to enable *"Long Paths"* since the bundled artifacts
> provided by this package often have longer path names that the default limit allows.
> See [this Microsoft document](https://docs.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation?tabs=powershell#enable-long-paths-in-windows-10-version-1607-and-later) for the steps required to enable this feature.

This Julia package provides access to several pre-built system images containing
collections of third-party Julia packages. It requires that your `julia` install
is managed using [`juliaup`](https://github.com/JuliaLang/juliaup).

It is an unregistered package and will remain this way since no package should
include this package in its dependencies. To install use Julia's `Pkg` mode in
your global project environment:

```
julia> import Pkg; Pkg.add(url = "https://github.com/MichaelHatherly/CuratedSystemImages.jl")
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

Now from the terminal run `julia` with one of the custom channel names that were
installed in the previous steps, e.g if you installed a system image for
`DataFrames` in Julia `1.7.3` then run

```bash
julia +1.7.3/CuratedSystemImages/DataFrames
```

If you selected to install "short names" for some channels then you'll be able to do

```bash
julia +DataFrames
```

to start with the system image containing `DataFrames` instead.

### Notes

#### Default channels

Do not set any of the custom channels as the `juliaup` default channel. This will
result in an infinite loop where the default channel attempts to call itself. This
may cause your system to hang.

#### `startup.jl` and latency

Please note that if you are importing any packages in your `.julia/config/startup.jl`
that happen to use different versions of packages included in the system image that
you launch then you will likely encounter some amount of startup latency. Running with
`--startup-file=no` will mitigate this latency.

#### Installing packages when using a custom system image

It is not advised to install additional packages into the named environment that the
system image launches with by default, e.g. `@DataFrames` for an image called `DataFrames`.
If you need to install extra packages then ensure that you use `--project=` to start a
custom project environment. It will still have access to the packages installed in the
custom system image. Ensure that you install extra packages using `add --preserve=all`
rather than the default behaviour which may upgrade dependencies to versions which are
not included in the system image which may cause the image to load incorrectly or not at all.

## Available Images

Currently the following system image bundles are provided:

  - `AlgebraOfGraphics`, contains the [Algebra of Graphics](https://github.com/JuliaPlots/AlgebraOfGraphics.jl)
    plotting package along with the Cairo-based `Makie` backend, and `DataFrames`.
  - `DataFrames`, contains the `DataFrames` and `DataFramesMeta` packages.
  - `JuliaSyntax`, contains [`JuliaSyntax`](https://github.com/JuliaLang/JuliaSyntax.jl)
    and uses the provided precompile scripts to reduce latency and enable `JuliaSyntax`
    as the default parser for all code.
  
Requests for additional images can be made to [`curated-system-images`](https://github.com/MichaelHatherly/curated-system-images)
repo where the manifests and build scripts are located for the above images.

## How does it work?

We use the [`SystemImageLoader.jl`](https://github.com/MichaelHatherly/SystemImageLoader.jl)
package to define an installer and loader for the lazy Julia artifacts that contain
the system image bundles. Installing a particular bundle sets up a `juliaup` channel
that points `SystemImageLoader` at the right system image file and associated Julia depot
folder containing the artifacts required by the chosen system image.
