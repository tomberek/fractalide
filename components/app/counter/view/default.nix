{ stdenv, buildFractalideSubnet, upkeepers
  , app_counter_viewer
  , app_counter_create
  , io_print
  , ip_action
  , ip_clone
  , ip_dispatcher
  , ui_js_block
  , ui_js_tag
  , ...}:
  let
  doc = import ../../../doc {};
  in
  buildFractalideSubnet rec {
   src = ./.;
   subnet = ''
   input => input in_dispatch(${ip_dispatcher}) output -> input out_dispatch(${ip_dispatcher}) output => output

   td(${ui_js_block}) output -> input out_dispatch()

   lr(${ui_js_block}) output -> places[0] td()

   button(${ui_js_tag}) output -> places[0] lr()
   button2(${ui_js_tag}) output -> places[2] lr()
   text(${ui_js_tag}) output -> places[1] lr()

   in_dispatch() output[model] -> input viewer(${app_counter_viewer}) label -> input text()

   button() output[click] -> input minus(${ip_action}) output -> input out_dispatch()
   button2() output[click] -> input add(${ip_action}) output -> input out_dispatch()
   'generic_text:(text="minus")' -> option minus()
   'generic_text:(text="add")' -> option add()


   input(${ui_js_tag}) output -> places[1] td()

   input() output[input] -> input delta(${ip_action}) output -> input out_dispatch()
   'generic_text:(text="delta")' -> option delta()

   viewer() delta -> input input()

   in_dispatch() output[create] -> input create(${app_counter_create})
   create() label -> input text()
   create() delta -> input input()
   create() minus -> input button()
   create() plus -> input button2()
   create() td -> input td()
   create() lr -> input lr()

   in_dispatch() output[delete] -> input create_clone(${ip_clone})
   create_clone() clone[1] -> input button()
   create_clone() clone[2] -> input button2()
   create_clone() clone[3] -> input text()
   create_clone() clone[4] -> input input()
   '';

   meta = with stdenv.lib; {
    description = "Subnet: Counter app";
    homepage = https://github.com/fractalide/fractalide/tree/master/components/development/test;
    license = with licenses; [ mpl20 ];
    maintainers = with upkeepers; [ dmichiels sjmackenzie];
  };
}
