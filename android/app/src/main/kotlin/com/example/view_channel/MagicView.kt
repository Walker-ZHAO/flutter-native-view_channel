package com.example.view_channel

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.TextView
import androidx.constraintlayout.widget.ConstraintLayout

/**
 * 原生View组件
 *
 * Author: walker
 * Email: zhaocework@gmail.com
 * Date: 2022/4/21
 */
class MagicView @JvmOverloads constructor(
    context: Context, attrs:
    AttributeSet? = null,
    defStyleAttr: Int = 0,
    defStyleRes: Int = 0
) : ConstraintLayout(context, attrs, defStyleAttr, defStyleRes) {

    private val view: View = LayoutInflater.from(context).inflate(R.layout.view_magic, this)
    private val receive by lazy { view.findViewById<TextView>(R.id.receive) }
    private val send by lazy { view.findViewById<TextView>(R.id.send) }
    private val sendButton by lazy { view.findViewById<Button>(R.id.sendButton) }
    var onSendButtonClick: (String) -> Unit = {}

    init {
        initView()
    }

    private fun initView() {
        val sendText = context.getString(R.string.send_value)
        send.text = context.getString(R.string.send_title, sendText)
        sendButton.setOnClickListener { onSendButtonClick(sendText) }
    }

    fun receiveMessage(text: String) {
        receive.text = context.getString(R.string.receive_title, text)
    }
}