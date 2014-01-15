package="lgmp"
version="0.1-1"
source = {
   url = "git://github.com/cyisfor/lgmp.git",
   dir='lgmp'
}
description = {
   summary = "GNU MP multiprecision library interface",
   detailed = [[
       The package offers the GNU multiple precision arithmetic library [1] for Lua 5.1. Currently it supports only the integer, floating point and random state types. I have no plans (yet) to add support for rationals.
   ]],
   homepage = "http://members.chello.nl/~w.couwenberg/lgmp.htm",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1"
}

external_dependencies = {
    GMP = { library = "gmp" }
}

build = {
   -- type = "command", build_command="bash",
   type="builtin",
   modules = {
      gmp = "gmp.lua",
      _gmp = {
         sources = {
            "lgmp.c",
         },
         incdirs = {
            "."
         },
         libraries = {
             "gmp",
         }

      }
   },
}
