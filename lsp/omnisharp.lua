return {
    settings = {
        -- Enables support for roslyn analyzers, code fixes and rulesets.
        enable_roslyn_analyzers = false,

        -- Specifies whether 'using' directives should be grouped and sorted during document formatting.
        organize_imports_on_format = false,

        -- Enables support for showing unimported types and unimported extension methods in completion lists.
        enable_import_completion = true,

        -- Specifies whether to include preview versions of the .NET SDK when determining which version to use.
        sdk_include_prereleases = true,

        -- Only run analyzers against open files when 'enableRoslynAnalyzers' is true.
        analyze_open_documents_only = false,
    },
}
