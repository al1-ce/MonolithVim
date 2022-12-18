
require('yabs'):setup({
    languages = {
        d = {
            tasks = {
                build = {
                    command = '/home/al1-ce/.config/nvim/yabs/dlang.sh',
                    type = 'shell',
                    output = 'quickfix'
                }
            }
        }
    },
    opts = {
        output_types = {
            quickfix = {
                open_on_run = 'always'
            }
        }
    }
})