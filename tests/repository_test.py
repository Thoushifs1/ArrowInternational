import os
import pytest
import subprocess
from unittest.mock import patch


# Function to simulate running pre-commit hooks
def run_pre_commit():
    try:
        result = subprocess.run(["pre-commit", "run", "--all-files"], capture_output=True, text=True, check=True)
        return result.stdout
    except subprocess.CalledProcessError as e:
        return e.stdout + e.stderr


# Test case to check pre-commit hooks execution
@patch("subprocess.run")
def test_pre_commit_hooks(mock_run):
    mock_run.return_value = subprocess.CompletedProcess(
        args=["pre-commit", "run", "--all-files"], returncode=0, stdout="Pre-commit hooks passed."
    )
    output = run_pre_commit()
    assert "Pre-commit hooks passed." in output
    mock_run.assert_called_once_with(["pre-commit", "run", "--all-files"], capture_output=True, text=True, check=True)


# Test case to handle failure in pre-commit hooks
@patch("subprocess.run")
def test_pre_commit_hooks_fail(mock_run):
    mock_run.side_effect = subprocess.CalledProcessError(
        returncode=1,
        cmd=["pre-commit", "run", "--all-files"],
        output="Error: some hooks failed.",
        stderr="Fix the issues and retry."
    )
    output = run_pre_commit()
    assert "Error: some hooks failed." in output
    assert "Fix the issues and retry." in output
    mock_run.assert_called_once_with(["pre-commit", "run", "--all-files"], capture_output=True, text=True, check=True)


if __name__ == "__main__":
    pytest.main()
