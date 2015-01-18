
#!/bin/sh

INSTALL_FILES=(\
  vimrc \
  vim \
  zshrc \
  zsh \
  tmux.conf \
  gitconfig \
)

SOURCE_DIR=$(dirname "${PWD}/${0}")

for FILE in ${INSTALL_FILES[@]}
do
  if [[ -e "${HOME}/.${FILE}" ]]
  then
    echo "${HOME}/.${FILE} already exists"
  else
    /bin/ln -s "${SOURCE_DIR}/${FILE}" "${HOME}/.${FILE}"
  fi
done


if [[ -e "${HOME}/.ssh/config" ]]
then
  echo "${HOME}/.ssh/config already exists"
else
  /bin/ln -s "${SOURCE_DIR}/ssh_config" "${HOME}/.ssh/config"
fi

