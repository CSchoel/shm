templ_full = IO.read("genSeidelPerfScript_templ.txt");
templ_entry = IO.read("genSeidelPerfScript_templ_sim.txt");

bvals = [0.1, 0.2, 0.3, 0.4, 0.5, 1, 2, 3]

simcalls = ""
bvals.each do |broad_len|
  simcalls += templ_entry % broad_len
end

puts templ_full % simcalls
