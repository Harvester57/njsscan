# Agent Instructions for njsscan

Welcome to the `njsscan` project! This document provides essential context and instructions for AI agents working on this codebase. It helps ensure consistency, maintains quality, and streamlines the development process.

## Project Overview

`njsscan` is a static application security testing (SAST) tool specifically designed to find insecure code patterns in Node.js applications. It utilizes a combination of tools to perform its analysis:
*   [**libsast**](https://github.com/ajinabraham/libsast): For simple, regex-based pattern matching.
*   [**semgrep**](https://github.com/returntocorp/semgrep): For syntax-aware, semantic code pattern searching.

## Directory Structure

*   `njsscan/`: Core Python package directory.
    *   `__main__.py`: CLI entrypoint.
    *   `njsscan.py`: The main orchestrator and scanning logic.
    *   `rules/`: Contains the YAML rules used by semgrep and libsast to identify vulnerabilities.
    *   `formatters/`: Output formatters (JSON, SARIF, SonarQube, HTML, etc.).
    *   `settings.py`: Default settings, severity levels, and configuration constants.
*   `tests/`: Test suite, using pytest.
*   `tox.ini`: Configuration for running tests, linting, formatting, and other automated tasks.
*   `Dockerfile`: Docker image definition for running njsscan.

## Technology Stack

*   **Language**: Python 3.7+
*   **Core Dependencies**: `semgrep`, `libsast`
*   **Testing**: `pytest`, managed via `tox`
*   **Linting & Formatting**: `flake8`, `autopep8`, `pydocstyle`, `bandit`

## Development Workflow & Rules

When making changes to this repository, agents **must** adhere to the following guidelines:

### 1. Local CI Validation Suite
To ensure your changes pass the continuous integration pipeline (as defined in `.github/workflows/python_test.yml`), run the following commands to validate your code and rules locally:

*   **Linting and Formatting**: `tox -e lint`
    Code must be formatted using `autopep8` and linted with `flake8`. Fix all reported issues before concluding the task.
*   **Python Security Checks**: `tox -e bandit`
    Performs security static analysis on the Python codebase.
*   **Semgrep Rule Validation**: `semgrep --validate --strict --config=./njsscan/rules/semantic_grep/`
    Ensures that all YAML rules are syntactically valid.
*   **Semgrep Rule Tests**: 
    ```bash
    export SEMGREP_R2C_INTERNAL_EXPLICIT_SEMGREPIGNORE=./tests/assets/.semgrepignore
    semgrep --quiet --test --config ./njsscan/rules/semantic_grep ./tests/assets/node_source/true_positives/semantic_grep/
    ```
    Evaluates your rules against positive and negative test cases to prevent regressions and false positives.
*   **Unit Tests**: `tox -e py312` (or `py311`, `py313`, `py314`, `py` depending on your local Python version)
    Runs the `pytest` test suite. When adding new features or output formats, add corresponding tests in the `tests/` directory.
*   **Clean Up**: `tox -e clean`
    Removes temporary test files and pycache directories.

### 2. Adding/Modifying Rules
*   Rule definitions are located in `njsscan/rules/`.
*   When adding new security rules (especially `semgrep` rules), ensure they are highly accurate to avoid false positives. 
*   Always run the Semgrep Rule Validation and Rule Tests (detailed above) when altering these rules.

### 3. Documentation
*   If command-line arguments, API methods, or core behaviors are modified, update the `README.md` to reflect these changes.
*   Maintain clear and concise docstrings for all new or modified Python classes and functions.

## Common Agent Tasks

*   **Evaluating Rule Coverage**: When analyzing rules, compare the existing set in `njsscan/rules/` with known Node.js security vulnerabilities (e.g., OWASP Top 10) to identify and implement missing checks.
*   **Fixing CI/Lint Issues**: Run `tox -e lint`, review the output, apply fixes, and re-run until successful.
