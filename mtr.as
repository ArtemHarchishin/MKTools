package MKTools {
public function mtr(condition:*, ...rest):Boolean {
    if (!condition) return false;

    for each(var o:* in rest){
        if (o is Object) {
    		var o_print:String = "\nit's Object: ";
            var is_p:Boolean = false;
            for (var p:String in o){
                o_print += p + " = " + o[p] + ', ';
                is_p = true;
            }
            if (is_p) {
				trace(o_print.slice(0, o_print.length - 2));
				trace('\n');
            }
        }
    }

    var new_rest:Array=[];
    for each(var o:* in rest){
        new_rest.push(o == null ? 'null':o);
    }

    var call:Array = new Error().getStackTrace().split('\n')[2].split('[');

    var t:Array = call[0].split('/');
    var call_m:String = t[t.length - 1];
    call_m = call_m.slice(0, call_m.length - 2);
    if (call_m.indexOf(':') >= 0) {
        t = call_m.split(':');
        call_m = t[t.length - 1];
    }

    var call_l:String = call[1];
    call_l = call_l.split(':')[1];
    call_l = call_l.slice(0, call_l .length - 1);

    if (rest.length == 0) trace('--->', call_m + ":" + call_l, '<---');
    else trace(call_m + ":" + call_l,'->', new_rest.join(" :: "), '<-');
    return true;
}
}
