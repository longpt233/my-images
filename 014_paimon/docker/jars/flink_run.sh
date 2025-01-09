Action "run" compiles and runs a program.

  Syntax: run [OPTIONS] <jar-file> <arguments>
  "run" action options:
     -c,--class <classname>                     Class with the program entry
                                                point ("main()" method). Only
                                                needed if the JAR file does not
                                                specify the class in its
                                                manifest.
     -C,--classpath <url>                       Adds a URL to each user code
                                                classloader  on all nodes in the
                                                cluster. The paths must specify
                                                a protocol (e.g. file://) and be
                                                accessible on all nodes (e.g. by
                                                means of a NFS share). You can
                                                use this option multiple times
                                                for specifying more than one
                                                URL. The protocol must be
                                                supported by the {@link
                                                java.net.URLClassLoader}.
     -cm,--claimMode <arg>                      Defines how should we restore
                                                from the given savepoint.
                                                Supported options: [claim -
                                                claim ownership of the savepoint
                                                and delete once it is subsumed,
                                                no_claim (default) - do not
                                                claim ownership, the first
                                                checkpoint will not reuse any
                                                files from the restored one,
                                                legacy (deprecated) - the old
                                                behaviour, do not assume
                                                ownership of the savepoint
                                                files, but can reuse some shared
                                                files.
     -d,--detached                              If present, runs the job in
                                                detached mode
     -n,--allowNonRestoredState                 Allow to skip savepoint state
                                                that cannot be restored. You
                                                need to allow this if you
                                                removed an operator from your
                                                program that was part of the
                                                program when the savepoint was
                                                triggered.
     -p,--parallelism <parallelism>             The parallelism with which to
                                                run the program. Optional flag
                                                to override the default value
                                                specified in the configuration.
     -py,--python <pythonFile>                  Python script with the program
                                                entry point. The dependent
                                                resources can be configured with
                                                the `--pyFiles` option.
     -pyarch,--pyArchives <arg>                 Add python archive files for
                                                job. The archive files will be
                                                extracted to the working
                                                directory of python UDF worker.
                                                For each archive file, a target
                                                directory be specified. If the
                                                target directory name is
                                                specified, the archive file will
                                                be extracted to a directory with
                                                the specified name. Otherwise,
                                                the archive file will be
                                                extracted to a directory with
                                                the same name of the archive
                                                file. The files uploaded via
                                                this option are accessible via
                                                relative path. '#' could be used
                                                as the separator of the archive
                                                file path and the target
                                                directory name. Comma (',')
                                                could be used as the separator
                                                to specify multiple archive
                                                files. This option can be used
                                                to upload the virtual
                                                environment, the data files used
                                                in Python UDF (e.g.,
                                                --pyArchives
                                                file:///tmp/py37.zip,file:///tmp
                                                /data.zip#data --pyExecutable
                                                py37.zip/py37/bin/python). The
                                                data files could be accessed in
                                                Python UDF, e.g.: f =
                                                open('data/data.txt', 'r').
     -pyclientexec,--pyClientExecutable <arg>   The path of the Python
                                                interpreter used to launch the
                                                Python process when submitting
                                                the Python jobs via "flink run"
                                                or compiling the Java/Scala jobs
                                                containing Python UDFs.
     -pyexec,--pyExecutable <arg>               Specify the path of the python
                                                interpreter used to execute the
                                                python UDF worker (e.g.:
                                                --pyExecutable
                                                /usr/local/bin/python3). The
                                                python UDF worker depends on
                                                Python 3.8+, Apache Beam
                                                (version == 2.43.0), Pip
                                                (version >= 20.3) and SetupTools
                                                (version >= 37.0.0). Please
                                                ensure that the specified
                                                environment meets the above
                                                requirements.
     -pyfs,--pyFiles <pythonFiles>              Attach custom files for job. The
                                                standard resource file suffixes
                                                such as .py/.egg/.zip/.whl or
                                                directory are all supported.
                                                These files will be added to the
                                                PYTHONPATH of both the local
                                                client and the remote python UDF
                                                worker. Files suffixed with .zip
                                                will be extracted and added to
                                                PYTHONPATH. Comma (',') could be
                                                used as the separator to specify
                                                multiple files (e.g., --pyFiles
                                                file:///tmp/myresource.zip,hdfs:
                                                ///$namenode_address/myresource2
                                                .zip).
     -pym,--pyModule <pythonModule>             Python module with the program
                                                entry point. This option must be
                                                used in conjunction with
                                                `--pyFiles`.
     -pypath,--pyPythonPath <arg>               Specify the path of the python
                                                installation in worker
                                                nodes.(e.g.: --pyPythonPath
                                                /python/lib64/python3.7/).User
                                                can specify multiple paths using
                                                the separator ":".
     -pyreq,--pyRequirements <arg>              Specify a requirements.txt file
                                                which defines the third-party
                                                dependencies. These dependencies
                                                will be installed and added to
                                                the PYTHONPATH of the python UDF
                                                worker. A directory which
                                                contains the installation
                                                packages of these dependencies
                                                could be specified optionally.
                                                Use '#' as the separator if the
                                                optional parameter exists (e.g.,
                                                --pyRequirements
                                                file:///tmp/requirements.txt#fil
                                                e:///tmp/cached_dir).
     -rm,--restoreMode <arg>                    This option is deprecated,
                                                please use 'claimMode' instead.
     -s,--fromSavepoint <savepointPath>         Path to a savepoint to restore
                                                the job from (for example
                                                hdfs:///flink/savepoint-1537).
     -sae,--shutdownOnAttachedExit              If the job is submitted in
                                                attached mode, perform a
                                                best-effort cluster shutdown
                                                when the CLI is terminated
                                                abruptly, e.g., in response to a
                                                user interrupt, such as typing
                                                Ctrl + C.
  Options for Generic CLI mode:
     -D <property=value>   Allows specifying multiple generic configuration
                           options. The available options can be found at
                           https://nightlies.apache.org/flink/flink-docs-stable/
                           ops/config.html
     -e,--executor <arg>   DEPRECATED: Please use the -t option instead which is
                           also available with the "Application Mode".
                           The name of the executor to be used for executing the
                           given job, which is equivalent to the
                           "execution.target" config option. The currently
                           available executors are: "remote", "local",
                           "kubernetes-session", "yarn-per-job" (deprecated),
                           "yarn-session".
     -t,--target <arg>     The deployment target for the given application,
                           which is equivalent to the "execution.target" config
                           option. For the "run" action the currently available
                           targets are: "remote", "local", "kubernetes-session",
                           "yarn-per-job" (deprecated), "yarn-session". For the
                           "run-application" action the currently available
                           targets are: "kubernetes-application",
                           "yarn-application".

  Options for yarn-cluster mode:
     -d,--detached                        If present, runs the job in detached
                                          mode
     -m,--jobmanager <arg>                Set to yarn-cluster to use YARN
                                          execution mode.
     -yat,--yarnapplicationType <arg>     Set a custom application type for the
                                          application on YARN
     -yD <property=value>                 use value for given property
     -yd,--yarndetached                   If present, runs the job in detached
                                          mode (deprecated; use non-YARN
                                          specific option instead)
     -yh,--yarnhelp                       Help for the Yarn session CLI.
     -yid,--yarnapplicationId <arg>       Attach to running YARN session
     -yj,--yarnjar <arg>                  Path to Flink jar file
     -yjm,--yarnjobManagerMemory <arg>    Memory for JobManager Container with
                                          optional unit (default: MB)
     -ynl,--yarnnodeLabel <arg>           Specify YARN node label for the YARN
                                          application
     -ynm,--yarnname <arg>                Set a custom name for the application
                                          on YARN
     -yq,--yarnquery                      Display available YARN resources
                                          (memory, cores)
     -yqu,--yarnqueue <arg>               Specify YARN queue.
     -ys,--yarnslots <arg>                Number of slots per TaskManager
     -yt,--yarnship <arg>                 Ship files in the specified directory
                                          (t for transfer)
     -ytm,--yarntaskManagerMemory <arg>   Memory per TaskManager Container with
                                          optional unit (default: MB)
     -yz,--yarnzookeeperNamespace <arg>   Namespace to create the Zookeeper
                                          sub-paths for high availability mode
     -z,--zookeeperNamespace <arg>        Namespace to create the Zookeeper
                                          sub-paths for high availability mode

  Options for default mode:
     -D <property=value>             Allows specifying multiple generic
                                     configuration options. The available
                                     options can be found at
                                     https://nightlies.apache.org/flink/flink-do
                                     cs-stable/ops/config.html
     -m,--jobmanager <arg>           Address of the JobManager to which to
                                     connect. Use this flag to connect to a
                                     different JobManager than the one specified
                                     in the configuration. Attention: This
                                     option is respected only if the
                                     high-availability configuration is NONE.
     -z,--zookeeperNamespace <arg>   Namespace to create the Zookeeper sub-paths
                                     for high availability mode
