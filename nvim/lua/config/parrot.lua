local M = {}

function M.setup()
  require("parrot").setup {
    providers = {
      openai = {
        api_key = os.getenv("OPENAI_API_KEY"),
      },
      github = {
        api_key = os.getenv("GITHUB_TOKEN"),
      }
    },

    -- default system prompts used for the chat sessions and the command routines
    --system_prompt = {
    --  chat = ...,
    --  command = ...
    --},

    -- the prefix used for all commands
    cmd_prefix = "Prt",

    -- optional parameters for curl
    curl_params = {},

    -- The directory to store persisted state information like the
    -- current provider and the selected models
    state_dir = vim.fn.stdpath("data") .. "/parrot/persisted",

    -- The directory to store the chats (searched with PrtChatFinder)
    chat_dir = vim.fn.stdpath("data") .. "/parrot/chats",

    -- Chat user prompt prefix
    chat_user_prefix = "🗨:",

    -- llm prompt prefix
    llm_prefix = "🦜:",

    -- Explicitly confirm deletion of a chat file
    chat_confirm_delete = true,

    -- When available, call API for model selection
    online_model_selection = false,

    -- Local chat buffer shortcuts
    chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g><C-g>" },
    chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>d" },
    chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>s" },
    chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>c" },

    -- Option to move the cursor to the end of the file after finished respond
    chat_free_cursor = false,

    -- use prompt buftype for chats (:h prompt-buffer)
    chat_prompt_buf_type = false,

    -- Default target for  PrtChatToggle, PrtChatNew, PrtContext and the chats opened from the ChatFinder
    -- values: popup / split / vsplit / tabnew
    toggle_target = "vsplit",

    -- The interactive user input appearing when can be "native" for
    -- vim.ui.input or "buffer" to query the input within a native nvim buffer
    -- (see video demonstrations below)
    user_input_ui = "native",

    -- Popup window layout
    -- border: "single", "double", "rounded", "solid", "shadow", "none"
    style_popup_border = "single",

    -- margins are number of characters or lines
    style_popup_margin_bottom = 8,
    style_popup_margin_left = 1,
    style_popup_margin_right = 2,
    style_popup_margin_top = 2,
    style_popup_max_width = 160,

    -- Prompt used for interactive LLM calls like PrtRewrite where {{llm}} is
    -- a placeholder for the llm name
    command_prompt_prefix_template = "🤖 {{llm}} ~ ",

    -- auto select command response (easier chaining of commands)
    -- if false it also frees up the buffer cursor for further editing elsewhere
    command_auto_select_response = true,

    -- fzf_lua options for PrtModel and PrtChatFinder when plugin is installed
    fzf_lua_opts = {
      ["--ansi"] = true,
      ["--sort"] = "",
      ["--info"] = "inline",
      ["--layout"] = "reverse",
      ["--preview-window"] = "nohidden:right:75%",
    },

    -- Enables the query spinner animation 
    enable_spinner = true,
    -- Type of spinner animation to display while loading
    -- Available options: "dots", "line", "star", "bouncing_bar", "bouncing_ball"
    spinner_type = "star",
  }
end

return M
