float opUnion( in float d1, in float d2 ) {
    return min(d1, d2);
}

Material opUnion( in Material d1, in Material d2 ) {
    if (d1.sdf < d2.sdf) {
        return d1;
    } else {
        return d2;
    }
}
