## Ubuntu 20.04 Image with PyEnv

---

For a lot of reasons, you might find yourself needing an Ubuntu base image with Python installed, rather than just a python base image.

From my experience, simply installing PyEnv to target a specific version can be significantly easier than building from source, which can come with its own version-specific hurdles.

The Dockerfile contained within this repo can be pretty much any Python version you could need, just alter the 

```dockerfile
RUN set -ex \
    && curl https://pyenv.run | bash \
    && pyenv update \
    && pyenv install 3.9.0 \    # <<<< This part
    && pyenv global 3.9.0 \     # <<<< & this part
    && pyenv rehash
```

to be the version that you need. 

From there, you can just reference pip and python the way that you normally would without any aliasing or symlinks.

[ insert easy button here ]