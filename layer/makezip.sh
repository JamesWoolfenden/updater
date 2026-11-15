#!/bin/sh
set -e
cd "$(dirname "$0")"
rm -rf python mylayer.zip
MSYS_NO_PATHCONV=1 docker run --rm --entrypoint /bin/sh -v "$PWD":/var/task -w /var/task \
  public.ecr.aws/sam/build-python3.12 \
  -c "pip install -r requirements.txt -t python/lib/python3.12/site-packages/ && python -m zipfile -c mylayer.zip python"
rm -rf python
