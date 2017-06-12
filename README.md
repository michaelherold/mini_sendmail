# mini_sendmail (Flywheel Edition)

## Requirements

To build this package, you need the GCC toolchain. Without doing a bunch of
jumping through hoops, macOS only has access to the Clang toolchain, which has
a different grammar for linking than GCC does. Since we host on Ubuntu, we have
to build with GCC instead of Clang.

### Step 1 - Create a droplet and install Git

The easiest way to get going is to start with a new DigitalOcean droplet on our
current version of Ubuntu. Once it’s provisioning, SSH into the box with
whatever key you added to the box. Then, install Git with the following:

    $ sudo apt-get update -q && sudo apt-get install -q -y git

### Step 2a - Copy your SSH key from your computer to your droplet (Option 1)

After Git is installed, you should configure SSH so that you will be able to
pull from this private repository. The easiest way to do this is to copy your
SSH key from your laptop to the server.

Start a new terminal session on your computer and run this command, making sure
to replace the template values (denoted like `<VARIABLE>`) with ones that match
your configuration:

    $ scp -i <KEY_TO_CONNECT_WITH> <KEY_TO_SEND> root@<DROPLET_IP>:~/.ssh

### Step 2b - Add an SSH key to your GitHub account (Option 2)

Alternatively, if you are security conscious, you can generate a new SSH key
with the following:

    $ ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -q -N “”
    $ cat ~/.ssh/id_ed25519.pub

Then, add this SSH key to your GitHub account by copying the output of
that last command into a new key on GitHub at:

    https://github.com/settings/keys

### Step 3 - Start an SSH Agent

After getting a key set up to pull from GitHub, you will want to start an SSH
agent to hold that key for connecting. Run this command and enter the passphrase
for your SSH key, if any:

    $ eval $(ssh-agent)

### Step 3 - Clone the Git repository

One you have SSH and GitHub configured, you can clone this repository and run
the setup script:

    $ git clone git@github.com:getflywheel/mini_sendmail.git

### Step 4 - Run the setup script

The repository has a script that will install everything that you need to
install and package

    $ cd mini_sendmail && bin/setup

## Building

To build the executable, execute the following from within the Git repository:

    $ make

This outputs the executable (`mini_sendmail`) in the root directory of the Git
repository.

## Testing

To run the tests we have written, run the following from within the Git
repository root:

    $ make test

## Packaging

To build the Debian package, run the following from within the Git repository
root:

    $ make package

This will build the package and place it in the parent directory above the Git
repository root.

## Releasing

The `VERSION` file holds the version that will be embedded in the program.
Increment it appropriately, then rebuild and make the package. The value that
you put in `VERSION` should be greater than the last version, but otherwise we
do not have a versioning schema.

We are currently distributing the package with Chef in the `flywheel-apt`
cookbook. You will want to download the `.deb` package file to your local
machine in order to update the Chef cookbook with the new version.

You will also need to update the version of the package in the
`mini_sendmail::default` Chef cookbook.
