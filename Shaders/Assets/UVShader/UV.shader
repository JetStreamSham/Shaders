Shader "Unlit/UV"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };


            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = float4(v.uv.xy,0,0);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                half4 c = frac(i.uv);
                if(any(saturate(i.uv)-i.uv))
                    c.b = 0.5;
                return c;
            }
            ENDCG
        }
    }
}
