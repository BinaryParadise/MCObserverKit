//
//  macrodefines.h
//  XMPPPressureTest
//
//  Created by odyang on 17/2/9.
//  Copyright © 2017年 maintoco. All rights reserved.
//

#ifndef macrodefines_h
#define macrodefines_h

#define keypath(...) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-repeated-use-of-weak\"") \
meta_macro_if_eq(1, meta_macro_argcount(__VA_ARGS__))(keypath1(__VA_ARGS__))(keypath2 (__VA_ARGS__)) \
_Pragma("clang diagnostic pop") \

#define keypath1(PATH) \
(((void)(NO && ((void)PATH, NO)), strchr(# PATH, '.') + 1))

#define keypath2(OBJ, PATH) \
(((void)(NO && ((void)OBJ.PATH, NO)), # PATH))

#define meta_macro_argcount(...) \
        meta_macro_at(10, __VA_ARGS__, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1)

#define meta_macro_if_eq(A, B) \
        meta_macro_concat(meta_macro_if_eq, A)(B)

#define meta_macro_concat(A, B) A ## B

#define meta_macro_at(N, ...) \
        meta_macro_concat(meta_macro_at, N)(__VA_ARGS__)

#define meta_macro_consume_(...)
#define meta_macro_expand_(...) __VA_ARGS__

#define meta_macro_dec(VAL) \
        meta_macro_at(VAL, _, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9)

#define metamacro_head(...) \
        metamacro_head_(__VA_ARGS__, 0)

#define metamacro_head_(FIRST, ...) FIRST

#define meta_macro_if_eq0(VALUE) \
        meta_macro_concat(meta_macro_if_eq0_, VALUE)

#define meta_macro_if_eq0__(...) meta_macro_expand_
#define meta_macro_if_eq0_0(...) __VA_ARGS__ meta_macro_consume_
#define meta_macro_if_eq0_1(...) meta_macro_expand_
#define meta_macro_if_eq0_2(...) meta_macro_expand_
#define meta_macro_if_eq0_3(...) meta_macro_expand_
#define meta_macro_if_eq0_4(...) meta_macro_expand_
#define meta_macro_if_eq0_5(...) meta_macro_expand_
#define meta_macro_if_eq0_6(...) meta_macro_expand_
#define meta_macro_if_eq0_7(...) meta_macro_expand_
#define meta_macro_if_eq0_8(...) meta_macro_expand_
#define meta_macro_if_eq0_9(...) meta_macro_expand_
#define meta_macro_if_eq0_10(...) meta_macro_expand_

#define meta_macro_if_eq1(VALUE) meta_macro_if_eq0(meta_macro_dec(VALUE))
#define meta_macro_if_eq2(VALUE) meta_macro_if_eq1(meta_macro_dec(VALUE))
#define meta_macro_if_eq3(VALUE) meta_macro_if_eq2(meta_macro_dec(VALUE))
#define meta_macro_if_eq4(VALUE) meta_macro_if_eq3(meta_macro_dec(VALUE))
#define meta_macro_if_eq5(VALUE) meta_macro_if_eq4(meta_macro_dec(VALUE))
#define meta_macro_if_eq6(VALUE) meta_macro_if_eq5(meta_macro_dec(VALUE))
#define meta_macro_if_eq7(VALUE) meta_macro_if_eq6(meta_macro_dec(VALUE))
#define meta_macro_if_eq8(VALUE) meta_macro_if_eq7(meta_macro_dec(VALUE))
#define meta_macro_if_eq9(VALUE) meta_macro_if_eq8(meta_macro_dec(VALUE))
#define meta_macro_if_eq10(VALUE) meta_macro_if_eq9(meta_macro_dec(VALUE))

#define meta_macro_at_(...) metamacro_head(10,__VA_ARGS__)
#define meta_macro_at0(...) metamacro_head(__VA_ARGS__)
#define meta_macro_at1(_0, ...) metamacro_head(__VA_ARGS__)
#define meta_macro_at2(_0,_1, ...) metamacro_head(__VA_ARGS__)
#define meta_macro_at3(_0,_1,_2, ...) metamacro_head(__VA_ARGS__)
#define meta_macro_at4(_0,_1,_2,_3, ...) metamacro_head(__VA_ARGS__)
#define meta_macro_at5(_0,_1,_2,_3,_4, ...) metamacro_head(__VA_ARGS__)
#define meta_macro_at6(_0,_1,_2,_3,_4,_5, ...) metamacro_head(__VA_ARGS__)
#define meta_macro_at7(_0,_1,_2,_3,_4,_5,_6, ...) metamacro_head(__VA_ARGS__)
#define meta_macro_at8(_0,_1,_2,_3,_4,_5,_6,_7, ...) metamacro_head(__VA_ARGS__)
#define meta_macro_at9(_0,_1,_2,_3,_4,_5,_6,_7,_8, ...) metamacro_head(__VA_ARGS__)
#define meta_macro_at10(_0,_1,_2,_3,_4,_5,_6,_7,_8,_9, ...) metamacro_head(__VA_ARGS__)

#endif /* macrodefines_h */
