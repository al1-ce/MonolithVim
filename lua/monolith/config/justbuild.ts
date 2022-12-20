// TypeScript source for justbuild.lua
// to compile this file into lua source
// use 'tstl -p ~/.config/nvim/tsconfig.json'
// command

declare function require(modname: string): any;
declare function print(val: any): void;

declare namespace vim {
    namespace fn {
        function system(com: string): string;
        function input(prompt: string, val: string): string;
    }
    function inspect(val: any): any;
    namespace bo {
        var filetype: string;
    }
    function cmd(expr: string): any;
}

/** @noSelf */
declare namespace telescope {
    let pickers: {
        new: (this: void, opts: any, obj: any) => any
    }
    namespace finders {
        function new_table(this: void, obj: any): any;
    }
    namespace config {
        namespace values {
            function generic_sorter(this: void, opts: any): any;
        }
    }
    namespace actions {
        namespace select_default {
            function replace(this: any, callback: Function): any;
        }
        namespace state {
            function get_selected_entry(this: void): any;
        }
        function close(this: void, buf: any): any;
    }
    namespace themes {
        function get_dropdown(this: void, opts: any): any;
    }
    function register_extension(opts: any): any;
}

let telescope_ = require("telescope") as typeof telescope;
let pickers = require("telescope.pickers") as typeof telescope.pickers;
let finders = require("telescope.finders") as typeof telescope.finders;
let conf = require("telescope.config").values as typeof telescope.config.values;
let actions = require("telescope.actions") as typeof telescope.actions;
let action_state = require("telescope.actions.state") as typeof telescope.actions.state;
let themes = require("telescope.themes") as typeof telescope.themes;

let notify = require("notify");

function popup(message: string, errlvl: string = "info", title: string = "Info"): void {
    notify(message, errlvl, { title: title });
}

let just = "just -f ~/.config/nvim/justfile";

// function string::split(sep) {
//     if (sep == nil) {
//         sep = "%s";
//     }
//     let t = [];
//     for (str in string.gmatch(self, "([^" .. sep .. "]+)")) {
//         table.insert(t, str); 
//     }
//     return t;
// }

function get_build_names(lang: string = ""): string[] {
    let outlist: string = vim.fn.system(`${just} --list`);
    let arr: string[] = outlist.split('\n');
    // table.remove(tbl, 1);
    arr.shift();
    arr.pop();
    // table.remove(tbl, #tbl);
    let newArr: string[] = [];
    for (let i = 0; i < arr.length; ++i) {
        // popup(tbl[i]);
        let options = arr[i].split(" ");
        options = options.filter(e => e !== '');
        // print(vim.inspect(options));
        let name = options[0];
        if (name.toLowerCase() == lang.toLowerCase() || lang == "") {
            newArr.push(name);    
        } 
        // popup(`${name}: ${options.length}`, "info", "Info");
    }
    return newArr;
}

function fix_build_names(arr_names: any[]): any[] {
    let arr: any[] = [];
    for (let i = 0; i < arr_names.length; ++i) {
        let parts: string[] = arr_names[i].split("_");
        // print(vim.inspect(parts));
        let out: string = `${parts[0]}: `;
        // table.remove(parts, 1);
        parts.shift();
        // out = out + table.concat(parts, " ");
        out += parts.join(" ");
        // table.insert(t, [ out, tbl[i] ]);
        arr.push([out, arr_names[i]]);
    }
    return arr;
}

function get_build_args(build_name: string): string[] {
    let outshow = vim.fn.system(`${just} -s ${build_name}`)
    let outinfo = outshow.split(":")[0];
    // print(vim.inspect(outinfo));
    let args = outinfo.split(" ");
    // table.remove(args, 1);
    args.shift();
    if (args.length == 0) return [];
    let argsout: string[] = [];
    for (let i = 0; i < args.length; ++i) {
        let arg = args[i];
        let a = vim.fn.input(`${arg}: `, "");
        // table.insert(argsout, a);
        argsout.push(a);
    }
    // popup(`Command args: ${argsout.join(" ")}`);
    return argsout;
}

function build_runner(build_name: string): void {
    let args: string[] = get_build_args(build_name);
    let command: string = `${just} -d . ${build_name} ${args.join(" ")}`;
    // popup(command);
    let success: string = "aplay ~/.config/nvim/res/build_success.wav -q"; 
    let error: string = "aplay ~/.config/nvim/res/build_error.wav -q"; 
    let lcom: string = `:AsyncRun ( ${command} ) && ( ${success} ) || ( ${error} )`;
    // vim.cmd(":copen");
    vim.cmd(lcom);
    // popup("Done");
}

export function build_select(opts: any): void {
    if (opts == null) opts = [];
    let picker = pickers.new(opts, {
        prompt_title: "Build tasks",
        border: {},
        borderchars: [ "─", "│", "─", "│", "┌", "┐", "┘", "└" ], 
        finder: finders.new_table({
            results: fix_build_names(get_build_names()),
            entry_maker: (entry: any[]) => {
                return {
                    value: entry,
                    display: entry[0],
                    ordinal: entry[0]
                }
            }
        }),
        sorter: conf.generic_sorter(opts),
        attach_mappings: (buf: any, map: any) => {
            actions.select_default.replace(() => {
                actions.close(buf);
                let selection = action_state.get_selected_entry();
                // print(vim.inspect(selection));
                let build_name = selection.value[2];
                build_runner(build_name);
            });
            return true;
        }
    });
    picker.find();
}
export function build_select_lang(opts: any): void {
    if (opts == null) opts = [];
    let picker = pickers.new(opts, {
        prompt_title: `${vim.bo.filetype} build tasks`,
        border: {},
        borderchars: [ "─", "│", "─", "│", "┌", "┐", "┘", "└" ], 
        finder: finders.new_table({
            results: fix_build_names(get_build_names(vim.bo.filetype)),
            entry_maker: (entry: any[]) => {
                return {
                    value: entry,
                    display: entry[0],
                    ordinal: entry[0]
                }
            }
        }),
        sorter: conf.generic_sorter(opts),
        attach_mappings: (buf: any, map: any) => {
            actions.select_default.replace(() => {
                actions.close(buf);
                let selection = action_state.get_selected_entry();
                // print(vim.inspect(selection));
                let build_name = selection.value[2];
                build_runner(build_name);
            });
            return true;
        }
    });
    picker.find();
}

let borderConf = { borderchars: {
     prompt: [ "─", "│", " ", "│", "┌", "┐", "│", "│" ],
    results: [ "─", "│", "─", "│", "├", "┤", "┘", "└" ],
    preview: [ "─", "│", "─", "│", "┌", "┐", "┘", "└" ]
}}

export function run_build_select(): void {
    build_select(themes.get_dropdown(borderConf));
}

export function run_build_select_lang(): void {
    build_select_lang(themes.get_dropdown(borderConf));
}

export function run_default_task(): void {
    let current_language = vim.bo.filetype;
    let cmp1 = current_language.toLowerCase();
    let tasks: string[] = get_build_names();
    for (let i = 1; i < tasks.length; ++i) {
        let opts: string[] = tasks[i].split("_");
        if (opts.length == 2) {
            if (opts[0].toLowerCase() == cmp1.toLowerCase() &&
                opts[1].toLowerCase() == "default") {
                // popup(`Executing default task for '${current_language}'.`, "info", "Build");
                build_runner(tasks[i]);
                return;
            }
        }
    }
    popup(`Could not find default task for '${current_language}'. \nPlease select task from list.`, "warn", "Build");
    run_build_select();
}

// run_build_select();
// run_default_task();

