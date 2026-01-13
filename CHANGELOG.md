# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [v1.0.0] - 2026-01-07

### Added

- Initial stand up of repo and successful test deployment after extracting console-ui from main filmdrop terraform modules repository ([2](https://github.com/Element84/terraform-aws-filmdrop-ui/pull/2))
- Renaming from `console-ui` and all references to more idiomatic `filmdrop-ui` to align with rest of filmdrop ecosystem
- Fix an edge case of bucket name length being too long due to filmdrop inputs

### Changed

### Fixed

### Removed


## Unreleased

### Added

- Restored `filmdrop_ui_bucket_name` input variable to specify the S3 bucket for deploying the built UI application

### Changed

### Fixed

- Fixed `CONTENT_BUCKET` environment variable to use `filmdrop_ui_bucket_name` instead of the config bucket, preventing the built UI from being synced to the same bucket as the CodeBuild configuration

### Removed