-----------------------------------------------------------
-- Setup runtimepath: stdpath('config'), stdpath('data')
-----------------------------------------------------------
local function setup_rtp()
    vim.opt.rtp:remove(join_paths(vim.fn.stdpath('data'), 'site'))
    vim.opt.rtp:remove(join_paths(vim.fn.stdpath('data'), 'site', 'after'))
    vim.opt.rtp:prepend(join_paths(RUNTIME_DIR, 'site'))
    vim.opt.rtp:append(join_paths(RUNTIME_DIR, 'site', 'after'))

    vim.opt.rtp:remove(vim.fn.stdpath('config'))
    vim.opt.rtp:remove(join_paths( vim.fn.stdpath('config'), 'after' ))
    vim.opt.rtp:prepend(CONFIG_DIR)
    vim.opt.rtp:append(join_paths(CONFIG_DIR, 'after'))

    vim.cmd [[let &packpath = &runtimepath]]
    vim.cmd [["set spellfile" .. join_paths(CONFIG_DIR, "spell", "en.utf-8.add")]]
end

if DEBUG then
    print('<< Begin of Initial Envirnoment >>')
    print_rtp()
    print('OS_SYS=', OS_SYS)
    print('CONFIG_DIR=', CONFIG_DIR)
    print('RUNTIME_DIR=', RUNTIME_DIR)
    print('PACKAGE_ROOT=', PACKAGE_ROOT)
    print('INSTALL_PATH=', INSTALL_PATH)
    print('COMPILE_PATH=', COMPILE_PATH)
end

setup_rtp()

if DEBUG then
    print('<< End of Initial Envirnoment >>')
    print_rtp()
    print("stdpath('config')=" , vim.fn.stdpath('config'))
    print("stdpath('data')=", vim.fn.stdpath('data'))
end
