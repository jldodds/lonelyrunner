Require Import Coq.Reals.Rdefinitions.
Require Import Coq.Reals.Raxioms.
Require Import Coq.Reals.Rfunctions.
Require Import Coq.Lists.List.

Local Open Scope R.

Parameter floor : R -> R.

Axiom floor_correct : forall R1 R2, floor R1 = R2 ->
                              R2 <= R1 /\ exists (n : Z), (IZR n) = R2 /\ (forall n2, (IZR n2 < R1) -> (n2 <= n)%Z). 

Definition decimal_only_positive (r : R) : R :=
 r - floor r.

Definition get_positions (speeds : list nat) (time : R) :=
  map (fun x=> decimal_only_positive ((INR x) * time)) speeds.

Definition is_lonely (i : nat) (positions : list R) : Prop :=
  forall i2, i <> i2  -> (i < length positions)%nat -> (i2 < length positions)%nat ->
        (R_dist (nth_default R0 positions i) (nth_default R0 positions i2) >= ( 1 / (INR (length positions)))).

Definition the_conjecture :=
  forall (speeds : list nat) (runner : nat),
    (runner < length speeds)%nat ->
    NoDup speeds ->
    exists (time : R), is_lonely runner (get_positions speeds time).