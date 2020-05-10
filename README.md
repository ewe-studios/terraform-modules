# Terraform Modules
This repository contains [Terraform](https://www.terraform.io/) modules in the [Modules](./modules) directory for deploying on [AWS](https://aws.amazon.com/) and other infrastructure providers as we needed with different infrastructures as needed by us.

## How to use this Module

This repo has the following folder structure:

* [modules](https://github.com/Dream-Bench-Technologies/terraform-modules/tree/master/modules): This folder contains several standalone, reusable, production-grade modules that you can use to deploy Consul.
* [examples](https://github.com/Dream-Bench-Technologies/terraform-modules/tree/master/examples): This folder shows examples of different ways to combine the modules in the `modules` folder to deploy Consul.
* [root folder](https://github.com/Dream-Bench-Technologies/terraform-modules/tree/master): The root folder is *an example* of how to use the varying modules

## What's a Module?

A Module is a canonical, reusable, best-practices definition for how to run a single piece of infrastructure, such 
as a database or server cluster. Each Module is created using [Terraform](https://www.terraform.io/), and
includes automated tests, examples, and documentation. It is maintained both by the open source community and 
companies that provide commercial support. 

Instead of figuring out the details of how to run a piece of infrastructure from scratch, you can reuse 
existing code that has been proven in production. And instead of maintaining all that infrastructure code yourself, 
you can leverage the work of the Module community to pick up infrastructure improvements through
a version number bump.
 
 
## Who maintains this Module?

This Module is maintained by [Dream Bench Technologies](http://github.com/influx6). 

## How do I contribute to this Module?

Contributions are very welcome! Check out the [Contribution Guidelines](https://github.com/Dream-Bench-Technologies/terraform-modules/tree/master/CONTRIBUTING.md) for instructions.


## How is this Module versioned?

This Module follows the principles of [Semantic Versioning](http://semver.org/). You can find each new release, 
along with the changelog, in the [Releases Page](../../releases). 

During initial development, the major version will be 0 (e.g., `0.x.y`), which indicates the code does not yet have a 
stable API. Once we hit `1.0.0`, we will make every effort to maintain a backwards compatible API and use the MAJOR, 
MINOR, and PATCH versions on each release to indicate any incompatibilities. 

