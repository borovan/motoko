
(* pseudo-tags

There can be several abbreviated DW_TAGs in the
abbreviation table, each with a different attribute set.

To refer to the duplicated tags, we use the bits above
the 16 bits that are possible for DW_TAGs.

A regular tag is just a pseudo-tag with an ordinal of 0.

 *)

let pseudo_tag base ordinal =
  assert (base > 0 && base <= Dwarf5.dw_TAG_hi_user);
  base lor (ordinal lsr 16)

let dw_TAG_member_Pointer_mark = pseudo_tag Dwarf5.dw_TAG_member 1
let dw_TAG_member_Word_sized = pseudo_tag Dwarf5.dw_TAG_member 2

let abbreviations =
  let open Dwarf5 in
  [ ( dw_TAG_compile_unit, dw_CHILDREN_yes,
      [ dw_AT_producer, dw_FORM_strp;
        dw_AT_language, dw_FORM_data2;
        dw_AT_name, dw_FORM_strp;
        dw_AT_stmt_list, dw_FORM_sec_offset;
        dw_AT_comp_dir, dw_FORM_strp;
        dw_AT_use_UTF8, dw_FORM_flag_present;
        dw_AT_low_pc, dw_FORM_addr;
        dw_AT_addr_base, dw_FORM_sec_offset;
        dw_AT_ranges, dw_FORM_sec_offset;
      ] );
    ( dw_TAG_subprogram, dw_CHILDREN_yes,
      [ dw_AT_low_pc, dw_FORM_addrx;
      (*dw_AT_high_pc, dw_FORM_data4;
         (* dw_AT_GNU_all_call_sites, dw_FORM_flag_present; *) *)
      dw_AT_name, dw_FORM_strp;
      (*dw_AT_decl_file, dw_FORM_data1;*)
      dw_AT_decl_line, dw_FORM_data1;
      dw_AT_decl_column, dw_FORM_data1;
      dw_AT_prototyped, dw_FORM_flag_present;
      dw_AT_external, dw_FORM_flag(*_present*)
      ] );
    ( dw_TAG_formal_parameter, dw_CHILDREN_no,
      [ dw_AT_name, dw_FORM_strp;
        (*dw_AT_decl_file, dw_FORM_data1;*)
        dw_AT_decl_line, dw_FORM_data1;
        dw_AT_decl_column, dw_FORM_data1;
      (*dw_AT_type, dw_FORM_ref_udata*)
      ] );
    ( dw_TAG_base_type, dw_CHILDREN_no,
      [ dw_AT_name, dw_FORM_strp;
        dw_AT_bit_size, dw_FORM_data1;
        dw_AT_data_bit_offset, dw_FORM_data1
      ] );
    ( dw_TAG_structure_type, dw_CHILDREN_yes,
      [ dw_AT_name, dw_FORM_strp;
        dw_AT_byte_size, dw_FORM_data1
      ] );
    ( dw_TAG_member_Pointer_mark, dw_CHILDREN_no,
      [ dw_AT_name, dw_FORM_strp;
        (*dw_AT_type, dw_FORM_ref_udata;*)
        dw_AT_artificial, dw_FORM_flag_present;
        dw_AT_bit_size, dw_FORM_data1;
        dw_AT_data_bit_offset, dw_FORM_data1
      ] );
    ( dw_TAG_member_Word_sized, dw_CHILDREN_no,
      [ dw_AT_name, dw_FORM_strp;
        (*dw_AT_type, dw_FORM_ref_udata;*)
        dw_AT_byte_size, dw_FORM_data1
      ] );
    ( dw_TAG_variant_part, dw_CHILDREN_yes,
      [ dw_AT_discr, dw_FORM_ref_udata
      ] );
    ( dw_TAG_variant, dw_CHILDREN_yes,
      [ dw_AT_name, dw_FORM_strp;
        dw_AT_byte_size, dw_FORM_data1
      ] )
  ]
