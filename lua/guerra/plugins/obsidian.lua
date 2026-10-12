return {
  -- Community fork; epwalsh/obsidian.nvim has had no release since v3.9.0 (2024-07)
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  ft = 'markdown',
  cmd = 'Obsidian',
  keys = {
    { '<leader>o', group = 'Obsidian' },
    { '<leader>oo', '<cmd>Obsidian quick_switch<cr>', desc = 'Obsidian Quick Switch' },
    { '<leader>oc', '<cmd>Obsidian new<cr>', desc = 'Obsidian New' },
    { '<leader>ot', '<cmd>Obsidian new_from_template<cr>', desc = 'Obsidian new from template' },
    { '<leader>od', '<cmd>Obsidian dailies<cr>', desc = 'Obsidian dailies' },
    { '<leader>ob', '<cmd>ObsidianNewFromBuffer<cr>', desc = 'Creates note from buffer' },
  },
  config = function()
    require('obsidian').setup({
      legacy_commands = false,
      workspaces = {
        {
          name = 'personal',
          path = '~/documents/vault/guerra - second mind/',
        },
      },
      completion = {
        min_chars = 2,
      },
      templates = {
        folder = 'Templates',
      },
      daily_notes = {
        folder = 'daily',
        template = 'Daily',
      },
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ''
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
        else
          suffix = tostring(math.random(1000, 9999))
        end
        return tostring('neovim notes/' .. os.time()) .. '-' .. suffix
      end,
    })

    vim.api.nvim_create_user_command('ObsidianNewFromBuffer', function()
      -- Prompt for the note title
      local title = vim.fn.input('Enter note title: ')
      if title == '' then
        print('Note creation cancelled.')
        return
      end

      -- Yank the entire content of the current buffer
      vim.cmd('normal! ggVGy')

      -- Create a new note with the specified title
      vim.cmd('Obsidian new ' .. vim.fn.fnameescape(title))

      -- Paste the yanked content into the new note
      vim.cmd('normal! ggP')

      -- Save the new note
      vim.cmd('write')
    end, {})
  end,
}
