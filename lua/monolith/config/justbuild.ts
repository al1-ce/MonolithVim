// TypeScript source for justbuild.lua
// to compile this file into lua source
// use 'tstl -p ~/.config/nvim/tsconfig.json'
// command

declare function require(modname: string): any;
declare function print(val: any): void;

declare namespace vim {
    namespace fn {
        function system(this: void, com: string): string;
        function input(this: void, prompt: string, val: string): string;
        function getcwd(this: void): string;
        function filereadable(this: void, file: string): number;
        function expand(this: void, str: string): string;
    }
    function inspect(this: void, val: any): any;
    namespace bo {
        var filetype: string;
    }
    function cmd(this: void, expr: string): any;
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
}

declare namespace io {
    function open(this: void, name: string, mode: string): any;
    function close(this: void, file: any): any;
}

declare namespace os {
    function date(format: string): string;
    function getenv(varname: string): string;
    function execute(command: string): string;
}

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

function get_build_names(lang: string = ""): string[][] {
    let outlist: string = vim.fn.system(`${just} --list`);
    let arr: string[] = outlist.split('\n');
    // table.remove(tbl, 1);
    arr.shift();
    arr.pop();
    
    let pjustfile: string = `${vim.fn.getcwd()}/justfile`;
    if (vim.fn.filereadable(pjustfile) == 1 && pjustfile != vim.fn.expand("~/.config/nvim/justfile")) { 
        let overrideList: string = vim.fn.system(`just -f ${pjustfile} --list`);
        let oarr: string[] = overrideList.split("\n");
        oarr.shift();
        oarr.pop();
        let rem: boolean = false;
        for (let i = 0; i < arr.length; ++i) {
            for (let j = 0; j < oarr.length; ++j) {
                let fnor: string =  arr[i].split(" ").filter(e => e !== '')[0];
                let fnov: string = oarr[j].split(" ").filter(e => e !== '')[0];
                // popup(`${fnor} : ${fnov}`);
                if (fnor == fnov) {
                    rem = true;
                }
            }
            if (rem) arr.splice(i, 1);
            rem = false;
        }
        arr = arr.concat(oarr);
    }
    //////////////////// add vim.fn.cwd()
    // table.remove(tbl, #tbl);
    let tbl: string[][] = [];
    for (let i = 0; i < arr.length; ++i) {
        // popup(tbl[i]);
        let comment: string = arr[i].split("#")[1];
        let options: string[] = arr[i].split("#")[0].split(" ");
        options = options.filter(e => e !== '');
        // print(vim.inspect(options));
        let name = options[0];
        let langname = (name.split("_")[0]).toLowerCase();
        // popup(langname);
        if (langname == lang.toLowerCase() || lang == "" || langname == "any") {
            // tbl.push(name);
            let parts: string[] = name.split("_");
            let out: string;
            if (parts.length == 1) {
                out = parts[0];
            } else {
                out = `${parts[0]}: `;
                parts.shift();
                out += parts.join(" ");
            }
            let wd = 34;
            let rn = Math.max(0, wd - out.length);
            out += `${" ".repeat(rn)} ${comment == null ? "" : comment}`;
            tbl.push([out, name]);
        } 
        // popup(`${name}: ${options.length}`, "info", "Info");
    }
    return tbl;
}

/**
@summary Checks if argument is defined as keyword (i.e "FILEPATH", "FILEEXT") and 
returns corresponding string. If argument is not keyword function returns single space 
@param arg Argument to check
*/
function check_keyword_arg(arg: string): string {
    switch (arg) {
        // Full file path
        case "FILEPATH": return vim.fn.expand("%:p"); 
        // Full file name
        case "FILENAME": return vim.fn.expand("%:t");
        // File path without filename
        case "FILEDIR": return vim.fn.expand("%:p:h");
        // File extension
        case "FILEEXT": return vim.fn.expand("%:e");
        // File name without extension
        case "FILENOEXT": return vim.fn.expand("%:t:r");
        // Current directory
        case "CWD": return vim.fn.getcwd();
        // Relative file path
        case "RELPATH": return vim.fn.expand("%");
        // Relative file path without filename
        case "RELDIR": return vim.fn.expand("%:h");
        // Time and date consts
        case "TIME": return os.date("%H:%M:%S");
        // Date in Day/Month/Year format
        case "DATE": return os.date("%d/%m/%Y");
        // Date in Month/Day/Year format
        case "USDATE": return os.date("%m/%d/%Y");
        // User name
        case "USERNAME": return os.getenv("USER");
        // PC name
        case "PCNAME": return vim.fn.system("uname -a").split(" ")[1]; 
        // OS
        case "OS": return vim.fn.system("uname").split("\n")[0];
        default: return " ";
    } 
}

function get_build_args(build_name: string): string[] {
    let justloc = just;
    let pjustfile: string = `${vim.fn.getcwd()}/justfile`;
    if (vim.fn.filereadable(pjustfile) == 1) { 
        let bd: string = vim.fn.system(`just -f ${pjustfile} --summary`);
        if (bd.split(" ").includes(build_name)) {
            justloc = `just -f ${pjustfile}`; 
        }
    }
    let outshow = vim.fn.system(`${justloc} -s ${build_name}`);
    if (outshow.startsWith("#")) {
        outshow = outshow.split("\n")[1];
    }
    let outinfo = outshow.split(":")[0];
    // print(vim.inspect(outinfo));
    let args = outinfo.split(" ");
    // table.remove(args, 1);
    args.shift();
    if (args.length == 0) return [];
    let argsout: string[] = [];
    for (let i = 0; i < args.length; ++i) {
        let arg = args[i];
        let keywd = check_keyword_arg(arg);
        if (keywd == " ") {
            let a: string = vim.fn.input(`${arg}: `, "");
            // table.inser;t(argsout, a);
            // print(vim.inspect(a));
            // argsout.push(`"${a}"`);
            argsout.push(`"${a}"`);
        } else {
            if (keywd == "") keywd = " ";
            argsout.push(`"${keywd}"`);
        }
    }
    // popup(`Command args: ${argsout.join(" ")}`);
    return argsout;
}

function build_runner(build_name: string): void {
    let args: string[] = get_build_args(build_name);
    let justloc = just;
    let pjustfile: string = `${vim.fn.getcwd()}/justfile`;
    if (vim.fn.filereadable(pjustfile) == 1) { 
        let bd: string = vim.fn.system(`just -f ${pjustfile} --summary`);
        if (bd.split(" ").includes(build_name)) {
            justloc = `just -f ${pjustfile}`; 
        }
    }
    let command: string = `${justloc} -d . ${build_name} ${args.join(" ")}`;
    // popup(command);
    let success: string = "aplay ~/.config/nvim/res/build_success.wav -q"; 
    let error: string = "aplay ~/.config/nvim/res/build_error.wav -q"; 
    let lcom: string = `:AsyncRun ( ${command} ) && ( ${success} ) || ( ${error} )`;
    // vim.cmd(":copen");
    // popup(lcom);
    // print(vim.inspect(lcom));
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
            results: get_build_names(),
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
            results: get_build_names(vim.bo.filetype),
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
    let current_language: string = vim.bo.filetype;
    let cmp1: string = current_language.toLowerCase();
    let tasks: string[][] = get_build_names();
    for (let i = 0; i < tasks.length; ++i) {
        let opts: string[] = tasks[i][1].split("_");
        // popup(tasks[i][0]);
        if (opts.length == 2) {
            // popup(`${opts[0].toLowerCase()} == ${cmp1.toLowerCase()} : ${opts[1].toLowerCase()}`)
            if (opts[0].toLowerCase() == cmp1.toLowerCase() &&
                opts[1].toLowerCase() == "default") {
                // popup(`Executing default task for '${current_language}'.`, "info", "Build");
                build_runner(tasks[i][1]);
                return;
            } else if (opts[0].toLowerCase() == "any" &&
                opts[1].toLowerCase() == "default") {
                // popup(`Executing default task for '${current_language}'.`, "info", "Build");
                build_runner(tasks[i][1]);
                return;
            } 
        }
    }
    popup(`Could not find default task for '${current_language}'. \nPlease select task from list.`, "warn", "Build");
    run_build_select();
}

// run_build_select();
// run_default_task();

