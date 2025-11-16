MRuby::CrossBuild.new('freestanding-cross-minimal') do |conf|
  conf.toolchain :gcc

  # Override commands with cross-compiler
  conf.cc.command   = ENV['CC']     || 'riscv64-unknown-elf-gcc'
  conf.linker.command = ENV['LD']   || 'riscv64-unknown-elf-gcc'
  conf.archiver.command = ENV['AR'] || 'riscv64-unknown-elf-ar'

  # No libc, no startfiles, no builtin functions, no exceptions
  conf.cc.flags << %w[
    -ffreestanding
    -fno-builtin
    -fno-exceptions
    -fno-stack-protector
  ]

  # Disable _FORTIFY_SOURCE to avoid __fprintf_chk
  conf.cc.flags << '-U_FORTIFY_SOURCE'

  hacky_libc_include = '/home/ubuntu/newlib-cygwin/build-newlib/target/usr/local/riscv64-unknown-elf/include'

  # Stop mruby from adding platform includes
  conf.cc.include_paths.clear
  conf.cc.include_paths << ['include']
  conf.cc.include_paths << [hacky_libc_include]
  conf.cc.include_paths << ['build/riscv/include']

  # No linker flags, not stdlib, no crt*.o
  conf.linker.flags = %w[
    -nostdlib
    -nostartfiles
  ]

  # Build only the core library. Do NOT build `mruby` binary.
  conf.bins = []

  conf.gem core: 'mruby-io'
end
