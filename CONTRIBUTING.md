# Contributing to 3lue Library

Thank you for your interest in contributing to 3lue Library! This document provides guidelines and instructions for contributing to our project.

## Table of Contents

1. [Code of Conduct](#code-of-conduct)
2. [Getting Started](#getting-started)
3. [Development Setup](#development-setup)
4. [Making Changes](#making-changes)
5. [Code Style Guide](#code-style-guide)
6. [Testing](#testing)
7. [Documentation](#documentation)
8. [Pull Request Process](#pull-request-process)
9. [Release Process](#release-process)

## Code of Conduct

By participating in this project, you agree to abide by our Code of Conduct:
- Be respectful and inclusive
- Be patient and helpful
- Focus on what's best for the community
- Show empathy towards other community members

## Getting Started

1. **Fork the Repository**
   - Click the "Fork" button on the GitHub repository page
   - Clone your fork:
   ```bash
   git clone https://github.com/your-username/lib3lue.git
   cd lib3lue
   ```

2. **Set Up Development Environment**
   ```bash
   julia init.jl
   ```

3. **Create a Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Setup

### Required Tools
- Julia 1.6 or higher
- Git
- A code editor (VS Code, Atom, etc.)

### Project Structure
```
lib3lue/
├── src/            # Source code
├── test/           # Test files
├── docs/           # Documentation
├── public/         # Static files
└── uploads/        # Uploaded files
```

### Running Tests
```bash
julia test/runtests.jl
```

## Making Changes

1. **Before Making Changes**
   - Check existing issues and pull requests
   - Discuss your proposed changes in an issue
   - Ensure your changes align with project goals

2. **Making Code Changes**
   - Follow the code style guide
   - Write tests for new features
   - Update documentation
   - Keep commits focused and atomic

3. **Commit Messages**
   - Use present tense
   - Be descriptive but concise
   - Reference issues when applicable
   ```
   feat: add user authentication
   fix: resolve file upload error
   docs: update API documentation
   ```

## Code Style Guide

### Julia Style
- Follow Julia's style guide
- Use 4 spaces for indentation
- Maximum line length: 92 characters
- Use descriptive variable names
- Add type annotations where helpful

### File Organization
- One module per file
- Group related functions
- Keep files focused and concise
- Use meaningful file names

### Documentation
- Document all public functions
- Include examples where helpful
- Keep comments up-to-date
- Use docstrings for documentation

## Testing

### Writing Tests
- Write tests for new features
- Include edge cases
- Test error conditions
- Keep tests independent

### Test Structure
```julia
@testset "Feature Name" begin
    @test "basic functionality" begin
        # Test code
    end
    
    @test "edge case" begin
        # Test code
    end
end
```

## Documentation

### Types of Documentation
1. **Code Documentation**
   - Function docstrings
   - Type documentation
   - Module documentation

2. **User Documentation**
   - Installation guides
   - Usage examples
   - API documentation

3. **Developer Documentation**
   - Architecture overview
   - Development setup
   - Contribution guidelines

### Writing Documentation
- Use clear, concise language
- Include examples
- Keep documentation up-to-date
- Use proper formatting

## Pull Request Process

1. **Before Submitting**
   - Ensure tests pass
   - Update documentation
   - Rebase on latest main
   - Squash related commits

2. **Creating a Pull Request**
   - Use the PR template
   - Describe changes clearly
   - Reference related issues
   - Request reviews

3. **During Review**
   - Respond to feedback
   - Make requested changes
   - Keep the PR focused
   - Update as needed

## Release Process

1. **Versioning**
   - Follow semantic versioning
   - Update version numbers
   - Update changelog

2. **Release Steps**
   - Create release branch
   - Update documentation
   - Run final tests
   - Create GitHub release

## Getting Help

- Email: am3lue@gmail.com
- Open an issue for questions
- Check existing documentation
- Ask in the community chat

## Acknowledgments

Thank you to all our contributors! Your help makes this project better for everyone.

## License

By contributing to 3lue Library, you agree that your contributions will be licensed under the project's MIT License. 