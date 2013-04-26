%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%  This file is part of VivoMind Prolog Unicode Resources  
%  
%  VivoMind Prolog Unicode Resources is free software distributed using the
%  Creative Commons CC0 1.0 Universal (CC0 1.0) - Public Domain Dedication
%  license
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  Last modified: March 29, 2012

:- include('unicode_categories/unicode_category_cc_other_control').
:- include('unicode_categories/unicode_category_cf_other_format').
:- include('unicode_categories/unicode_category_cn_other_not_assigned').
:- include('unicode_categories/unicode_category_co_other_private_use').
:- include('unicode_categories/unicode_category_cs_other_surrogate').
:- include('unicode_categories/unicode_category_lc_letter_cased').
:- include('unicode_categories/unicode_category_ll_letter_lowercase').
:- include('unicode_categories/unicode_category_lm_letter_modifier').
:- include('unicode_categories/unicode_category_lo_letter_other').
:- include('unicode_categories/unicode_category_lt_letter_titlecase').
:- include('unicode_categories/unicode_category_lu_letter_uppercase').
:- include('unicode_categories/unicode_category_mc_mark_spacing_combining').
:- include('unicode_categories/unicode_category_me_mark_enclosing').
:- include('unicode_categories/unicode_category_mn_mark_nonspacing').
:- include('unicode_categories/unicode_category_nd_number_decimal_digit').
:- include('unicode_categories/unicode_category_nl_number_letter').
:- include('unicode_categories/unicode_category_no_number_other').
:- include('unicode_categories/unicode_category_pc_punctuation_connector').
:- include('unicode_categories/unicode_category_pd_punctuation_dash').
:- include('unicode_categories/unicode_category_pe_punctuation_close').
:- include('unicode_categories/unicode_category_pf_punctuation_final_quote').
:- include('unicode_categories/unicode_category_pi_punctuation_initial_quote').
:- include('unicode_categories/unicode_category_po_punctuation_other').
:- include('unicode_categories/unicode_category_ps_punctuation_open').
:- include('unicode_categories/unicode_category_sc_symbol_currency').
:- include('unicode_categories/unicode_category_sk_symbol_modifier').
:- include('unicode_categories/unicode_category_sm_symbol_math').
:- include('unicode_categories/unicode_category_so_symbol_other').
:- include('unicode_categories/unicode_category_zl_separator_line').
:- include('unicode_categories/unicode_category_zp_separator_paragraph').
:- include('unicode_categories/unicode_category_zs_separator_space').

:- ensure_loaded('unicode_cjk_radicals').
:- ensure_loaded('unicode_unihan_variants').

unicode_category(CodePoint, Category) :-
	(	nonvar(CodePoint) ->
		% find the actual category of the code point
		(	unicode_category_(CodePoint, ConvertedCategory) ->
			true
		;	unicode_unihan_variant(CodePoint, _, CodePointVariant),
			unicode_category_(CodePointVariant, ConvertedCategory) ->
			true
		;	unicode_cjk_radical(_, Radical, CodePoint),
			unicode_category_(Radical, ConvertedCategory) ->
			true
		;	fail
		),
		(	var(Category) ->
			% we have two solutions, the generic category and the specific category
			unicode_category_convert_(Category, ConvertedCategory)
		;	% only one solution, assuming the given category is valid
			unicode_category_convert_(Category, ConvertedCategory),
			!
		)
	;	% generate code point-category pairs
		(	unicode_category_(CodePoint, ConvertedCategory)
		;	unicode_unihan_variant(CodePoint, _, CodePointVariant),
			unicode_category_(CodePointVariant, ConvertedCategory)
		;	unicode_cjk_radical(_, Radical, CodePoint),
			unicode_category_(Radical, ConvertedCategory)
		),
		% check or unify the original category argument
		(	var(Category) ->
			% we have two solutions, the generic category and the specific category
			unicode_category_convert_(Category, ConvertedCategory)
		;	% only one solution, assuming the given category is valid but we
			% must allow backtracking to the next code point-category pair
			% without leraving spurious choice-points
			(	unicode_category_convert_(Category, ConvertedCategory) ->
				true
			;	fail
			)
		)
	).

unicode_category_convert_('C', 'Cc').
unicode_category_convert_('C', 'Cf').
unicode_category_convert_('C', 'Cn').
unicode_category_convert_('C', 'Co').
unicode_category_convert_('C', 'Cs').

unicode_category_convert_('Cc', 'Cc').
unicode_category_convert_('Cf', 'Cf').
unicode_category_convert_('Cn', 'Cn').
unicode_category_convert_('Co', 'Co').
unicode_category_convert_('Cs', 'Cs').

unicode_category_convert_('L', 'Lc').
unicode_category_convert_('L', 'Ll').
unicode_category_convert_('L', 'Lm').
unicode_category_convert_('L', 'Lo').
unicode_category_convert_('L', 'Lt').
unicode_category_convert_('L', 'Lu').

unicode_category_convert_('Lc', 'Lc').
unicode_category_convert_('Ll', 'Ll').
unicode_category_convert_('Lm', 'Lm').
unicode_category_convert_('Lo', 'Lo').
unicode_category_convert_('Lt', 'Lt').
unicode_category_convert_('Lu', 'Lu').

unicode_category_convert_('M', 'Mc').
unicode_category_convert_('M', 'Me').
unicode_category_convert_('M', 'Mn').

unicode_category_convert_('Mc', 'Mc').
unicode_category_convert_('Me', 'Me').
unicode_category_convert_('Mn', 'Mn').

unicode_category_convert_('N', 'Nd').
unicode_category_convert_('N', 'Nl').
unicode_category_convert_('N', 'No').

unicode_category_convert_('Nd', 'Nd').
unicode_category_convert_('Nl', 'Nl').
unicode_category_convert_('No', 'No').

unicode_category_convert_('P', 'Pc').
unicode_category_convert_('P', 'Pd').
unicode_category_convert_('P', 'Pe').
unicode_category_convert_('P', 'Pf').
unicode_category_convert_('P', 'Pi').
unicode_category_convert_('P', 'Po').
unicode_category_convert_('P', 'Ps').
                                
unicode_category_convert_('Pc', 'Pc').
unicode_category_convert_('Pd', 'Pd').
unicode_category_convert_('Pe', 'Pe').
unicode_category_convert_('Pf', 'Pf').
unicode_category_convert_('Pi', 'Pi').
unicode_category_convert_('Po', 'Po').
unicode_category_convert_('Ps', 'Ps').

unicode_category_convert_('S', 'Sc').
unicode_category_convert_('S', 'Sk').
unicode_category_convert_('S', 'Sm').
unicode_category_convert_('S', 'So').

unicode_category_convert_('Sc', 'Sc').
unicode_category_convert_('Sk', 'Sk').
unicode_category_convert_('Sm', 'Sm').
unicode_category_convert_('So', 'So').

unicode_category_convert_('Z', 'Zl').
unicode_category_convert_('Z', 'Zp').
unicode_category_convert_('Z', 'Zs').
                                
unicode_category_convert_('Zl', 'Zl').
unicode_category_convert_('Zp', 'Zp').
unicode_category_convert_('Zs', 'Zs').
