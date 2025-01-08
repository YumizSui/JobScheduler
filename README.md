# JobScheduler: Parallel-Friendly CSV Scheduler

A minimal CSV-based job scheduler designed to run jobs in parallel. Each row in a CSV file represents a job, with its parameters passed directly to an external script. The script automatically adds `status` and `job_id` columns if they’re missing, and uses file locks to prevent race conditions.

- **Automatic Columns**: Ensures `status` and `job_id` exist in the CSV (added if missing).
- **Configurable Runtime**: Set a `--max_runtime` to limit total scheduling time.
- **Reset (Optional)**: Run with `--reset` (not fully implemented) to reset `status` to `pending` and regenerate job IDs.

## Usage
```bash
job_scheduler <csv_file> <script_path> \
    [--lock_file <lock_file>] \
    [--job_lock_dir <job_lock_dir>] \
    [--max_runtime <seconds>] \
    [--reset]
```

Test cases are included in the `tests` directory. To run the tests, use the following command:
```bash
job_scheduler test_params.csv test_job.sh
```

`test_params.csv` contains the following:
```csv
paramA,paramB,status,job_id
foo,1,pending,job_6919c0dd
bar,2,pending,job_e8235261
baz,3,pending,job_89a33219
qux,4,pending,job_e61045fd
```

`paramA` and `paramB` are passed to `test_job.sh` as arguments.
`status` and `job_id` are automatically added if missing.

Locking relies on POSIX `fcntl`, so this will only work on Unix-like systems. All output and errors from the external script are logged in real time.

When using a supercomputer, you can use job scheduler like `qsub` and array jobs to run this script in parallel.

```bash
qsub -t 1-4 test_job.sh
```
