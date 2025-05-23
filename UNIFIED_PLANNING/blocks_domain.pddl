(define (domain blocks_world-domain)
  (:requirements :strips :typing :negative-preconditions :equality :universal-preconditions)
  (:types
    block pos agent
  )
  (:predicates
    (ontable ?block - block)
    (on ?block1 - block ?block2 - block)
    (at_ ?block - block ?pos - pos)
    (clear ?block - block)
    (available ?agent - agent)
    (moving_table_to_table ?agent - agent ?block - block ?from_pos - pos ?to_pos - pos)
    (moving_table_to_block ?agent - agent ?block1 - block ?block2 - block ?from_pos - pos ?to_pos - pos)
    (moving_onblock_to_table ?agent - agent ?block - block ?from_pos - pos ?to_pos - pos)
    (moving_onblock_to_block ?agent - agent ?block1 - block ?block2 - block ?from_pos - pos ?to_pos - pos)
  )
  (:action move_table_to_table_start
    :parameters ( ?agent - agent ?block - block ?from_pos - pos ?to_pos - pos)
    :precondition (and (ontable ?block) (at_ ?block ?from_pos) (available ?agent) (clear ?block) (forall
        (?any_block - block)
        (imply
          (not (= ?any_block ?block))
          (not (at_ ?any_block ?to_pos)))) (forall
        (?any_block - block)
        (not (on ?block ?any_block))) (forall
        (?any_agent - agent ?any_block - block ?any_pos - pos ?any_pos - pos)
        (imply
          (= ?any_block ?block)
          (not (moving_table_to_table ?any_agent ?any_block ?any_pos ?any_pos)))) (forall
        (?any_agent - agent ?any_block - block ?any_block2 - block ?any_pos - pos ?any_pos - pos)
        (imply
          (= ?any_block ?block)
          (not (moving_table_to_block ?any_agent ?any_block ?any_block2 ?any_pos ?any_pos)))))
    :effect (and (not (available ?agent)) (not (clear ?block)) (not (ontable ?block)) (not (at_ ?block ?from_pos)) (moving_table_to_table ?agent ?block ?from_pos ?to_pos))
  )
  (:action move_table_to_table_end
    :parameters ( ?agent - agent ?block - block ?from_pos - pos ?to_pos - pos)
    :precondition (and (moving_table_to_table ?agent ?block ?from_pos ?to_pos) (forall
        (?any_block - block)
        (imply
          (not (= ?any_block ?block))
          (not (at_ ?any_block ?to_pos)))))
    :effect (and (not (moving_table_to_table ?agent ?block ?from_pos ?to_pos)) (ontable ?block) (at_ ?block ?to_pos) (clear ?block) (available ?agent))
  )
  (:action move_table_to_block_start
    :parameters ( ?agent - agent ?block1 - block ?block2 - block ?from_pos - pos ?to_pos - pos)
    :precondition (and (available ?agent) (ontable ?block1) (at_ ?block1 ?from_pos) (at_ ?block2 ?to_pos) (clear ?block2) (clear ?block1) (not (= ?block1 ?block2)) (forall
        (?any_block - block)
        (not (on ?block1 ?any_block))) (forall
        (?any_block - block)
        (imply
          (not (= ?any_block ?block1))
          (not (on ?any_block ?block1)))) (forall
        (?any_agent - agent ?any_block - block ?any_pos - pos ?any_pos - pos)
        (imply
          (= ?any_block ?block1)
          (not (moving_table_to_table ?any_agent ?any_block ?any_pos ?any_pos)))) (forall
        (?any_agent - agent ?any_block - block ?any_block2 - block ?any_pos - pos ?any_pos - pos)
        (imply
          (= ?any_block ?block1)
          (not (moving_table_to_block ?any_agent ?any_block ?any_block2 ?any_pos ?any_pos)))))
    :effect (and (not (available ?agent)) (not (clear ?block1)) (not (ontable ?block1)) (not (at_ ?block1 ?from_pos)) (moving_table_to_block ?agent ?block1 ?block2 ?from_pos ?to_pos))
  )
  (:action move_table_to_block_end
    :parameters ( ?agent - agent ?block1 - block ?block2 - block ?from_pos - pos ?to_pos - pos)
    :precondition (and (moving_table_to_block ?agent ?block1 ?block2 ?from_pos ?to_pos) (clear ?block2))
    :effect (and (not (clear ?block2)) (not (moving_table_to_block ?agent ?block1 ?block2 ?from_pos ?to_pos)) (on ?block1 ?block2) (at_ ?block1 ?to_pos) (clear ?block1) (available ?agent))
  )
  (:action move_onblock_to_table_start
    :parameters ( ?agent - agent ?block1 - block ?block2 - block ?from_pos - pos ?to_pos - pos)
    :precondition (and (available ?agent) (on ?block1 ?block2) (at_ ?block1 ?from_pos) (at_ ?block2 ?from_pos) (clear ?block1) (not (= ?block1 ?block2)) (not (ontable ?block1)) (forall
        (?any_block - block)
        (imply
          (not (= ?any_block ?block1))
          (not (on ?any_block ?block1)))) (forall
        (?any_block - block)
        (imply
          (not (= ?any_block ?block1))
          (not (at_ ?any_block ?to_pos)))) (forall
        (?any_agent - agent ?any_block - block ?any_pos - pos ?any_pos - pos)
        (imply
          (= ?any_block ?block1)
          (not (moving_table_to_table ?any_agent ?any_block ?any_pos ?any_pos)))) (forall
        (?any_agent - agent ?any_block - block ?any_block2 - block ?any_pos - pos ?any_pos - pos)
        (imply
          (= ?any_block ?block1)
          (not (moving_table_to_block ?any_agent ?any_block ?any_block2 ?any_pos ?any_pos)))) (forall
        (?any_agent - agent ?any_block - block ?any_pos - pos ?any_pos - pos)
        (imply
          (= ?any_block ?block1)
          (not (moving_onblock_to_table ?any_agent ?any_block ?any_pos ?any_pos)))) (forall
        (?any_agent - agent ?any_block - block ?any_block2 - block ?any_pos - pos ?any_pos - pos)
        (imply
          (= ?any_block ?block1)
          (not (moving_onblock_to_block ?any_agent ?any_block ?any_block2 ?any_pos ?any_pos)))))
    :effect (and (not (available ?agent)) (not (clear ?block1)) (not (on ?block1 ?block2)) (not (at_ ?block1 ?from_pos)) (moving_onblock_to_table ?agent ?block1 ?from_pos ?to_pos) (clear ?block2))
  )
  (:action move_onblock_to_table_end
    :parameters ( ?agent - agent ?block1 - block ?from_pos - pos ?to_pos - pos)
    :precondition (and (moving_onblock_to_table ?agent ?block1 ?from_pos ?to_pos) (forall
        (?any_block - block)
        (imply
          (not (= ?any_block ?block1))
          (not (at_ ?any_block ?to_pos)))))
    :effect (and (not (moving_onblock_to_table ?agent ?block1 ?from_pos ?to_pos)) (ontable ?block1) (at_ ?block1 ?to_pos) (clear ?block1) (available ?agent))
  )
  (:action move_onblock_to_block_start
    :parameters ( ?agent - agent ?block1 - block ?block2 - block ?block3 - block ?from_pos - pos ?to_pos - pos)
    :precondition (and (available ?agent) (on ?block1 ?block3) (at_ ?block1 ?from_pos) (at_ ?block3 ?from_pos) (at_ ?block2 ?to_pos) (clear ?block2) (clear ?block1) (not (= ?block1 ?block2)) (not (= ?block1 ?block3)) (not (= ?block2 ?block3)) (not (ontable ?block1)) (forall
        (?any_block - block)
        (imply
          (not (= ?any_block ?block1))
          (not (on ?any_block ?block1)))) (forall
        (?any_agent - agent ?any_block - block ?any_pos - pos ?any_pos - pos)
        (imply
          (= ?any_block ?block1)
          (not (moving_table_to_table ?any_agent ?any_block ?any_pos ?any_pos)))) (forall
        (?any_agent - agent ?any_block - block ?any_block2 - block ?any_pos - pos ?any_pos - pos)
        (imply
          (= ?any_block ?block1)
          (not (moving_table_to_block ?any_agent ?any_block ?any_block2 ?any_pos ?any_pos)))) (forall
        (?any_agent - agent ?any_block - block ?any_pos - pos ?any_pos - pos)
        (imply
          (= ?any_block ?block1)
          (not (moving_onblock_to_table ?any_agent ?any_block ?any_pos ?any_pos)))) (forall
        (?any_agent - agent ?any_block - block ?any_block2 - block ?any_pos - pos ?any_pos - pos)
        (imply
          (= ?any_block ?block1)
          (not (moving_onblock_to_block ?any_agent ?any_block ?any_block2 ?any_pos ?any_pos)))))
    :effect (and (not (available ?agent)) (not (clear ?block1)) (not (on ?block1 ?block3)) (not (at_ ?block1 ?from_pos)) (moving_onblock_to_block ?agent ?block1 ?block2 ?from_pos ?to_pos) (clear ?block3))
  )
  (:action move_onblock_to_block_end
    :parameters ( ?agent - agent ?block1 - block ?block2 - block ?from_pos - pos ?to_pos - pos)
    :precondition (and (moving_onblock_to_block ?agent ?block1 ?block2 ?from_pos ?to_pos) (clear ?block2))
    :effect (and (not (clear ?block2)) (not (moving_onblock_to_block ?agent ?block1 ?block2 ?from_pos ?to_pos)) (on ?block1 ?block2) (at_ ?block1 ?to_pos) (clear ?block1) (available ?agent))
  )
)