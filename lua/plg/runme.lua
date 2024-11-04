return {
    -- ;x V;x - execute lines
    -- TODO: WIP
    {
        dir = "/g/al1-ce/runme.nvim",
        enabled = false,
        opts = {
            filetypes = {
                javascript = {
                    cmd = "node run",
                },
                bash = {
                    cmd = "bash",
                },
                d = {
                    cmd = "dub run --single $FILENAME",
                    template = [[
                        /++ dub.sdl:
                        name: scratch
                        +/
                        import std;
                        void main() {
                            $RUNME_CODE
                        }
                    ]]
                },
                c = {
                    cmd = "gcc -o $FILEOUT $FILENAME && ./$FILEOUT",
                    template = [[
                        #include <stdio.h>
                        int main() {
                            $RUNME_CODE
                            return 0;
                        }
                    ]]
                }
            }
        },
        keys = {
            { "<leader>xc", "<cmd>Runme<cr>",      mode = "n", noremap = true, silent = true, desc = "E[X]ecute code" },
            { "<leader>xc", ":Runme<cr>",          mode = "v", noremap = true, silent = true, desc = "E[X]ecute code" },
            { "<leader>xp", "<cmd>RunmePaste<cr>", mode = "n", noremap = true, silent = true, desc = "E[X]ecute and [P]aste" },
            { "<leader>xp", ":RunmePaste<cr>",     mode = "v", noremap = true, silent = true, desc = "E[X]ecute and [P]aste" },
            { "<leader>xf", "<cmd>RunmeFile<cr>",  mode = "n", noremap = true, silent = true, desc = "E[X]ecute [F]ile" },
            { "<leader>xf", ":RunmeFile<cr>",      mode = "v", noremap = true, silent = true, desc = "E[X]ecute [F]ile" },
        },
        event = "VimEnter"
    }
}
