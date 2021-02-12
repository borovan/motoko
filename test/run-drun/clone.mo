import Prim "mo:prim";
import Cycles "cycles/cycles";
import Lib "clone/cloneable";

actor Cloner {

   // Calls Lib.Cloneable to construct a new Clonable,
   // passing itself as first argument, using available funds
   public shared func makeCloneable(init : Nat): async Lib.Cloneable {
      let accepted = Cycles.accept(Cycles.available());
      Cycles.add(accepted);
      await Lib.Cloneable(makeCloneable, init);
   };

   public shared func test() : async () {
      // get some cycles
      if (Cycles.balance() == (0 : Nat64))
      await Cycles.provisional_top_up_actor(Cloner, 100_000_000_000_000);

      // create the original Cloneable object
      Cycles.add(Prim.natToNat64(10_000_000_000_000));
      let c0 : Lib.Cloneable = await makeCloneable(0);
      await c0.someMethod();
      Prim.debugPrint(debug_show(Prim.principalOfActor c0));

      // create some proper clones
      let c1 = await c0.clone(1); // clone!
      await c1.someMethod();
      Prim.debugPrint(debug_show(Prim.principalOfActor c1));

      let c2 = await c1.clone(2); // clone!
      await c2.someMethod();
      Prim.debugPrint(debug_show(Prim.principalOfActor c2));
   }

};

// testing
//SKIP run
//SKIP run-ir
//SKIP run-low
ignore Cloner.test(); //OR-CALL ingress test "DIDL\x00\x00"