MRuby::CrossBuild.new('freestanding-host-minimal') do |conf|
  conf.toolchain :gcc

  # No libc, no startfiles, no builtin functions, no exceptions
  conf.cc.flags << %w[
    -ffreestanding
    -fno-builtin
    -fno-exceptions
    -fno-stack-protector
  ]

  # Disable _FORTIFY_SOURCE to avoid __fprintf_chk
  conf.cc.flags << '-U_FORTIFY_SOURCE'

  # Stop mruby from adding platform includes
  conf.cc.include_paths.clear
  conf.cc.include_paths << ['include']

  # No linker flags, not stdlib, no crt*.o
  conf.linker.flags = %w[
    -nostdlib
    -nostartfiles
  ]

  # Build only the core library. Do NOT build `mruby` binary.
  conf.bins = []

  conf.gem core: 'mruby-io'
end
