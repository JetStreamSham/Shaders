Shader "Normal/NormalColorShader"
{

    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include  "UnityCG.cginc"

            struct v2f
            {
                float3 color : COLOR0;
                float4 pos : SV_POSITION;
                float3 normal : NORMAL;
            };


            v2f vert (appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.color = v.normal * 0.5 + 0.5;
                return o;
            }

            float4 frag (v2f i) : COLOR
            {
                return fixed4(i.color,1);
            }
            ENDCG
        }
    }
}
