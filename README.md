# Module templates

    ProviderName
        └── ModuleName
                ├── main.tf
                ├── outputs.tf
                ├── README.md
                └── variables.tf

The list of **Providers** for Terraform can be found here: <https://registry.terraform.io/browse/providers>

**main.tf :** Call modules, locals and data-sources to create all resources \
**variables.tf :** Contains declarations of variables used in main.tf \
**outputs.tf :** Contains outputs from the resources created in main.tf

**Do not** use a locals.tf in the modules. \
Only use that in the environment directory and then pass those as variables to the modules.
